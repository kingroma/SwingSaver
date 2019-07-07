package com.swing.saver.web.controller;

import com.swing.saver.web.entity.Constant;
import com.swing.saver.web.entity.LoginVo;
import com.swing.saver.web.exception.ApiException;
import com.swing.saver.web.service.RestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by mycom on 2019-05-24.
 */
@RestController
@RequestMapping(Constant.REST_PREFIX+"/api")
public class RestApiController {
    private final static Logger LOGGER = LoggerFactory.getLogger(RestApiController.class);
    @Autowired
    private RestService restService;

    @GetMapping(value = "/token")
    public String getToken() throws ApiException{

        String res = restService.oAuthToken();
        return null;
    }

    /*@GetMapping(value = "/login")
    public String login() throws ApiException{
        LoginVo loginVo = null;
        HttpSession session = null;

        loginVo.setEmail("aaa@bbb.com");
        loginVo.setPassword("P@55w0rd");

        restService.loginProcess(loginVo, session);
        return null;
    }*/
}
