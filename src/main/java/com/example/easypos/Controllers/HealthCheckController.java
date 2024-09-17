package com.example.easypos.Controllers;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;
import java.util.TreeMap;

@Controller
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
        responseData.put("name", "abror");
        return ResponseEntity.ok(responseData);
    }

    @RequestMapping("/env")
    public ResponseEntity<?> getEnv(){
        return ResponseEntity.ok(env);
    }

    @RequestMapping("/test")
    public String test(){
        return "/usr/test/test";
    }
}
