package com.example.easypos.Controllers;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;
import java.util.TreeMap;

@RestController
public class HealthCheckController {
    @Value("${server.env}")
    private String env;
    @Value("${serverName}")
    private String serverName;
    @Value("${server.serverAddress}")
    private String serverAddress;
    @Value("${server.port}")
    private String serverPort;

    @GetMapping("/hc")
    public ResponseEntity<?> healthCheck(){
        Map<String, String> responseData = new TreeMap<>();
        responseData.put("env", env);
        responseData.put("serverName", serverName);
        responseData.put("serverAddress", serverAddress);
        responseData.put("serverPort", serverPort);
        return ResponseEntity.ok(responseData);
    }

    @GetMapping("/env")
    public String getEnv(){
        return "/usr/member/loginPage";
    }
}
