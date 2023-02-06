package com.example.web.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileController {

	@PostMapping("/upload")
	public @ResponseBody void upload(@RequestParam("file") MultipartFile mFile,  HttpServletResponse response) throws Exception {

		String fileSeparator = File.separator;
		String rootPath = System.getProperty("user.dir");
		String basePath = rootPath+fileSeparator+ "upload" ;//	+"\\src\\main\\resources\\static\\upload";

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
