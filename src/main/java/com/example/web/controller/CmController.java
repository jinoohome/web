package com.example.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CmController {

	@GetMapping("/")
	public String login() throws Exception {
		System.out.println("main");
		return "index";
	}

}
