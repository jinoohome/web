package com.example.web.sevice;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.tika.Tika;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import me.desair.tus.server.TusFileUploadService;
import me.desair.tus.server.exception.TusException;
import me.desair.tus.server.upload.UploadInfo;
import net.bramp.ffmpeg.FFmpeg;
import net.bramp.ffmpeg.FFmpegExecutor;
import net.bramp.ffmpeg.FFprobe;
import net.bramp.ffmpeg.builder.FFmpegBuilder;

@Slf4j
@Service
@RequiredArgsConstructor
public class FileUploadService {

    private final TusFileUploadService tusFileUploadService;

    public void process(HttpServletRequest request, HttpServletResponse response) {
        try {
            // Process a tus upload request
            tusFileUploadService.process(request, response);

            // Get upload information
            UploadInfo uploadInfo = tusFileUploadService.getUploadInfo(request.getRequestURI());

            if (uploadInfo != null && !uploadInfo.isUploadInProgress()) {
                // Progress status is successful: Create file

            	System.out.println(uploadInfo.getFileMimeType());
            	System.out.println(uploadInfo.getLength());
                createFile(tusFileUploadService.getUploadedBytes(request.getRequestURI()), uploadInfo);

                // Delete an upload associated with the given upload url
                tusFileUploadService.deleteUpload(request.getRequestURI());
            }
        } catch (IOException | TusException e) {
            log.error("exception was occurred. message={}", e.getMessage(), e);

            throw new RuntimeException(e);
        }
    }

    private void createFile(InputStream is, UploadInfo fileInfo) throws IOException {

    	String fileName = fileInfo.getFileName();
        File file = new File("upload/", fileName);
        FileUtils.copyInputStreamToFile(is, file);

        String fileType = fileInfo.getFileMimeType();
        String fileGubun = fileType.split("/")[0];
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1);

        String fileSeparator = File.separator;
		String rootPath = System.getProperty("user.dir");
		String basePath = rootPath+fileSeparator+ "upload" ;//+"\\src\\main\\resources\\static\\upload";

		String yymmdd = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		String realFilename = yymmdd+"_"+ String.valueOf(System.nanoTime()).substring(7)+"."+ext;

		String savePath = basePath + "/" + fileName;
		String renamePath = basePath + "/" + realFilename;

		String ffmpegUrl = rootPath+fileSeparator+"ffmpeg"+fileSeparator+"bin"+fileSeparator+"ffmpeg";
		String ffprobeUrl = rootPath+fileSeparator+"ffmpeg"+fileSeparator+"bin"+fileSeparator+"ffprobe";


		String os = System.getProperty("os.name").toLowerCase();
		if(os.contains("linux")) {
			ffmpegUrl = "/usr/bin/ffmpeg";
			ffprobeUrl = "/usr/bin/ffprob";
		}

        try {
			if(fileGubun.equals("video")){
				FFmpeg ffmpeg = new FFmpeg(ffmpegUrl);
				FFprobe ffprobe = new FFprobe(ffprobeUrl);

				//rpService.fspRp002U04(progressMap);
				FFmpegBuilder builder = new FFmpegBuilder()
						.setInput(savePath)
						.overrideOutputFiles(true)
						.addOutput(renamePath)
						.setFormat(ext)
						.setVideoCodec("libx264")
						.disableSubtitle()
						.setAudioChannels(2)
						//	.setVideoResolution(inputImage.getWidth(), inputImage.getHeight()) // ������ �ػ�
						.setVideoBitRate(1464800)
						.setStrict(FFmpegBuilder.Strict.EXPERIMENTAL)
						.done();

				//rpService.fspRp002U04(progressMap);

				FFmpegExecutor executor = new FFmpegExecutor(ffmpeg, ffprobe);
				executor.createJob(builder).run();

			}else if(fileGubun.equals("image")) {

//				rpService.fspRp002U04(progressMap);

				InputStream inputStream = new FileInputStream(file);
				BufferedImage inputImage = ImageIO.read(inputStream);

				Image resultingImage = inputImage.getScaledInstance(inputImage.getWidth(), inputImage.getHeight(), Image.SCALE_SMOOTH);
				BufferedImage outputImage = new BufferedImage(inputImage.getWidth(), inputImage.getHeight(), BufferedImage.TYPE_INT_RGB);
				Graphics2D graphics2D = outputImage.createGraphics();
//				rpService.fspRp002U04(progressMap);
				graphics2D.drawImage(resultingImage, 0, 0, inputImage.getWidth(), inputImage.getHeight(), null); // �׸���
				graphics2D.dispose();
				ImageIO.write(outputImage, ext, new File(renamePath));

			}

		} catch (Exception e) {
			System.out.println(e);
		}



    }
}