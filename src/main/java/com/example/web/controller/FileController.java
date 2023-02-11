package com.example.web.controller;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class FileController {

	@GetMapping("/file")
	public String login() throws Exception {
		return "file/file";
	}

	@PostMapping("/upload")
	public List<Map<String, Object>> upload(@RequestParam("files") MultipartFile mFile,  HttpServletResponse response) throws Exception {

		Map<String, Object> map = new HashMap<>();
		String fileSeparator = File.separator;
		String rootPath = System.getProperty("user.dir");
		String basePath = rootPath+fileSeparator+ "upload" ;//	+"\\src\\main\\resources\\static\\upload";
		File Folder = new File(basePath);

		// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!Folder.exists()) {
			try{
				Folder.mkdir(); //폴더 생성합니다.
			}
			catch(Exception e){
				e.getStackTrace();
			}
		}else {
		}


		List<MultipartFile> fileList  = (List<MultipartFile>) map.get("files");

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for(MultipartFile file : fileList) {
			String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
			String yymmdd = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

			String realFilename = yymmdd+"_"+ String.valueOf(System.nanoTime()).substring(7)+"."+ext;

			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			String yearMonth = String.valueOf(year)+ String.valueOf(month);
			//String filePath = "nui" + "\\" + "uploadFiles_fsms" + "\\"+ String.valueOf(cal.get(Calendar.YEAR))+ "\\" + realFilename;
			String filePath = "nui" + "\\" + "uploadFiles_fsms" + "\\" + "client" +"\\"+yearMonth+"\\" + realFilename;

			String fileType = file.getContentType().split("/")[0];


			map.put("fileName", file.getOriginalFilename());
			map.put("programId", "RP002");
			map.put("fileSize", file.getSize());
			map.put("filePath", filePath);
			map.put("realFilename",realFilename);
			map.put("mgNo","");
			map.put("fileType",fileType);



			map.put("filename", file.getOriginalFilename());
			map.put("fileSize", file.getSize());
			map.put("filePath", filePath);




			//Map<String, Object> result = rpService.fspRp002U05(map);


			map.put("realFilename", realFilename);
			map.put("fileName", file.getOriginalFilename());
			map.put("filePath", filePath);

			list.add(map);

		}


		return list;
	}

	@PostMapping("/fileSizeDown")
	public @ResponseBody List<Map<String, Object>> fileSizeDown(MultipartHttpServletRequest  request, HttpSession session) throws Exception {


		Map<String, Object> map = new HashMap<>();
		map.put("soNo", request.getParameter("soNo"));
		map.put("status", request.getParameter("status"));
		map.put("empNo", session.getAttribute("empNo"));
		map.put("files", request.getFiles("files"));


		JSONParser parser = new JSONParser();
		JSONArray values = (JSONArray)parser.parse(request.getParameter("data"));

		List<MultipartFile> fileList  = (List<MultipartFile>) map.get("files");

		String fileSeparator = File.separator;
		String rootPath = System.getProperty("user.dir");
		String basePath = rootPath+fileSeparator+ "upload" ;//+"\\src\\main\\resources\\static\\upload";
		File Folder = new File(basePath);

		// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
		if (!Folder.exists()) {
			try{
				Folder.mkdir(); //폴더 생성합니다.
			}
			catch(Exception e){
				e.getStackTrace();
			}
		}

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		for(MultipartFile file : fileList) {
			String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1);
			String realFilename = "";
			String filePath = "";
			String fileName = "";
			String mgNo = "";
			String originalName = file.getOriginalFilename();

			Map<String, Object> progressMap = new HashMap<>();

			for (int i = 0; i < values.size(); i++) {
				JSONObject value = (JSONObject)values.get(i);

				fileName = (String)value.get("fileName");

				if(fileName.equals(originalName)) {
					realFilename = (String)value.get("realFilename");
					filePath = (String)value.get("filePath");
					mgNo = (String)value.get("msgText");
					progressMap.put("mgNo", mgNo);

				}
			}


			progressMap.put("progress", "10");
//			rpService.fspRp002U04(progressMap);

			// 파일 이름 변경
			String savePath = basePath + "/" + originalName;
			String renamePath = basePath + "/" + realFilename;

			File dest = new File(savePath);
			if(!dest.exists()) {
				file.transferTo(dest);
			}

			String mimeType = new Tika().detect(dest);
			String fileGubun = mimeType.split("/")[0];

			progressMap.put("progress", "30");
//			rpService.fspRp002U04(progressMap);
			try {
				if(fileGubun.equals("video")){
					FFmpeg ffmpeg = new FFmpeg("src/main/resources/ffmpeg/bin/ffmpeg");
					FFprobe ffprobe = new FFprobe("src/main/resources/ffmpeg/bin/ffprobe");

					progressMap.put("progress", "40");
					rpService.fspRp002U04(progressMap);
					FFmpegBuilder builder = new FFmpegBuilder()
							.setInput(savePath) // 동영상 파일경로
							.overrideOutputFiles(true) // 오버라이드
							.addOutput(renamePath) // 변환 후 저장할 경로
							.setFormat(ext) // 포맷 ( 확장자 )
							.setVideoCodec("libx264") // 비디오 코덱
							.disableSubtitle() // 서브타이틀 제거
							.setAudioChannels(2) // 오디오 채널 ( 1 : 모노 , 2 : 스테레오 )
							//	.setVideoResolution(inputImage.getWidth(), inputImage.getHeight()) // 동영상 해상도
							.setVideoBitRate(1464800) // 비디오 비트레이트
							.setStrict(FFmpegBuilder.Strict.EXPERIMENTAL) // ffmpeg 빌더 실행 허용
							.done();

					progressMap.put("progress", "70");
					rpService.fspRp002U04(progressMap);

					FFmpegExecutor executor = new FFmpegExecutor(ffmpeg, ffprobe);
					executor.createJob(builder).run();

				}else if(fileGubun.equals("image")) {

					progressMap.put("progress", "40");
//					rpService.fspRp002U04(progressMap);

					InputStream inputStream = new FileInputStream(dest);
					BufferedImage inputImage = ImageIO.read(inputStream);  // 받은 이미지 읽기

					Image resultingImage = inputImage.getScaledInstance(inputImage.getWidth(), inputImage.getHeight(), Image.SCALE_SMOOTH);
					BufferedImage outputImage = new BufferedImage(inputImage.getWidth(), inputImage.getHeight(), BufferedImage.TYPE_INT_RGB);
					Graphics2D graphics2D = outputImage.createGraphics();
					progressMap.put("progress", "70");
//					rpService.fspRp002U04(progressMap);
					graphics2D.drawImage(resultingImage, 0, 0, inputImage.getWidth(), inputImage.getHeight(), null); // 그리기
					graphics2D.dispose(); // 자원해제
					ImageIO.write(outputImage, ext, new File(renamePath));

				}

			} catch (Exception e) {
				System.out.println(e);
			}

			progressMap.put("progress", "80");
//			rpService.fspRp002U04(progressMap);

//			cmService.saveFileServer2(renamePath);

			progressMap.put("progress", "100");
//			rpService.fspRp002U04(progressMap);

			//Path deleteFile = Paths.get(savePath);
			//Path deleteFile2 = Paths.get(renamePath);

			//Files.delete(deleteFile);
			//Files.delete(deleteFile2);

			File deleteFile = new File(savePath);
			File deleteFile2 = new File(renamePath);

			deleteFile.delete();
			deleteFile2.delete();
		}


		return null;

	}

}
