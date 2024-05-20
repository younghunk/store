package com.store.jinyoung.controller;

import java.net.URI;
import java.nio.charset.Charset;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriComponentsBuilder;

@RestController
@RequestMapping("/naver")
public class JYController {

	@GetMapping(value = "/search", produces = "application/json; charset=UTF-8")
	public ResponseEntity<String> naverSearchList(@RequestParam(name = "text") String text) {
		
		// 네이버 검색 API 클라이언트 ID
		String clientId = "UElIUiiiQzDWtEZrtU0K";
		String clientSecret = "I6i4eIQIVl";
		
		URI uri = UriComponentsBuilder
				.fromUriString("https://openapi.naver.com")
				.path("/v1/search/local.json")
				.queryParam("query", text)
				.queryParam("display", 5)
				.queryParam("start", 1)
				.queryParam("sort", "random")
				.encode(Charset.forName("UTF-8"))
				.build()
				.toUri();
		
		WebClient webClient = WebClient.builder()
				.defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.defaultHeader("X-Naver-Client-Id", clientId)
				.defaultHeader("X-Naver-Client-Secret", clientSecret)
				.build();
		
		ResponseEntity<String> responseEntity = webClient.get()
				.uri(uri)
				.retrieve()
				.toEntity(String.class)
				.block();
		
		String responseBody = responseEntity.getBody();
				
		return ResponseEntity.ok(responseBody);
	}
	
}
