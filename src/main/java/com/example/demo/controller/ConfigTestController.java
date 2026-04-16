package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ConfigTestController {
    @Value("${app.test-message}")
    private String testMessage;

    @GetMapping("/test-config")
    public String getTestMessage() {
        return "ConfigMap says: " + testMessage;
    }
}
