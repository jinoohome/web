package com.example.web.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileController {

	@GetMapping("/file")
	public String login() throws Exception {
		return "file/file";
	}

	@PostMapping("/upload")
	public @ResponseBody void upload(@RequestParam("files") MultipartFile mFile,  HttpServletResponse response) throws Exception {

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




		String originalName = mFile.getOriginalFilename();
		String savePath = basePath + fileSeparator+ originalName;  //원래 이름에 경로를 붙여준거
		File file = new File(savePath); //원래이름에 대한 파일을 찾음
		mFile.transferTo(file);

		//fileService.saveFileServer(savePath);

		//return Data
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("fileName", mFile.getOriginalFilename());
		result.put("fileSize", mFile.getSize());
		result.put("filePath", savePath);


//		Gson gson = new Gson();
//		System.out.println(gson.toJson(result));
//
//		response.setContentType("application/json");
//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().write(gson.toJson(result));


	}
}
