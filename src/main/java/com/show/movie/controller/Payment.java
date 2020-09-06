package com.show.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class Payment {

	@RequestMapping(value="/payment")
	public String mainPage( Model model) {
		log.info(getClass());
		
		return "payment";
	}
}
