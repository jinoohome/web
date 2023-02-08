package com.example.web.controller;

import java.io.File;
import java.util.HashMap;
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

		String fileSeparator = File.separator;
		String rootPath = System.getProperty("user.dir");
		String basePath = rootPath+fileSeparator+ "upload" ;//	+"\\src\\main\\resources\\static\\upload";

		String originalName = mFile.getOriginalFilename();
		String savePath = basePath + fileSeparator+ originalName;  //���� �̸��� ��θ� �ٿ��ذ�
		File file = new File(savePath); //�����̸��� ���� ������ ã��
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
