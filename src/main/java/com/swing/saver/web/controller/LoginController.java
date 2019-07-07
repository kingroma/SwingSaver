package com.swing.saver.web.controller;

import com.swing.saver.web.entity.Constant;
import com.swing.saver.web.entity.LoginVo;
import com.swing.saver.web.exception.ApiException;
import com.swing.saver.web.service.RestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

/**
 * Created by mycom on 2019-06-04.
 */
@Controller
@RequestMapping(Constant.ROOT_PREFIX)
public class LoginController {
    private final static Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

    @Inject
    RestService restService;

    @GetMapping("/")
    public ModelAndView index(ModelAndView mv, HttpServletRequest request) throws Exception {
        LOGGER.info("==================== LoginController index Strart : ====================");
        LoginVo loginVo = (LoginVo) request.getSession().getAttribute("login");

        mv.addObject("isLogin", loginVo.getResult());
        mv.setViewName("/index");
        return mv;
    }
    /**
     * 1. 메소드명 : loginForm
     * 2. 작성자 :
     * 3. 설명 : 로그인폼
     * */
    @GetMapping("/loginForm")
    public String loginForm(HttpServletRequest request) {
        return "web/log_01_01";
    }
    @PostMapping(value = "/login")
    public ModelAndView login(LoginVo loginVo, HttpServletRequest request,HttpSession session,ModelAndView mv,RedirectAttributes redirectAttributes) throws ApiException, IOException {
        LOGGER.debug("==================== LoginController login Strart : ====================");
        String rtnUrl = "";
        session = request.getSession(true);
        session.setAttribute("authCheck", true);

        boolean authCheck = (Boolean)request.getSession().getAttribute("authCheck");
        if(!authCheck){
            redirectAttributes.addFlashAttribute("authCheck", !authCheck);
            rtnUrl = "redirect:/loginForm";
        }else {

            /*로그인 호출 LoginVo 리턴*/
            loginVo = restService.loginProcess(loginVo,session);
            if(loginVo != null && "true".equals(loginVo.getResult())){
                LOGGER.debug("로그인 성공 사용자id:{},사용자 권한:{}",loginVo.getUserid(),loginVo.getGroupadmin());
                /*session.setMaxInactiveInterval(60*60);*/
                session.setAttribute("login",loginVo);
                /*mv.addObject("isLoign",loginVo.getResult());*/
                rtnUrl = "redirect:/";
            } else {
                LOGGER.debug("로그인 실패 : {}", loginVo.getResult());

                redirectAttributes.addFlashAttribute("returnCode", "9999");
                //redirectAttributes.addFlashAttribute("loginVo", loginVo);
                rtnUrl = "redirect:/loginForm";
            }
        }

        mv.setViewName(rtnUrl);

        LOGGER.debug("==================== LoginController login End : ====================");
        return mv;
    }
    @GetMapping(value = "/logout")
    public String logout(HttpSession session) throws ApiException, UnsupportedEncodingException {

        LOGGER.debug("==================== LoginController logout Start: {}====================");
        if ( session.getAttribute("login") != null ){
            // 기존에 login이란 세션 값이 존재한다면
            session.invalidate(); // 세션 전체를 날려버림
        }

        LOGGER.debug("==================== LoginController logout End : {}====================");
        return "redirect:/loginForm";
    }
    /*
	 * 로그인을 완료한 사용자의 아이디를 세션에 저장하는 메소드
	 * @param session 세션 객체
	 * @param userID 사용자 아이디
	 */
    public void setSession(HttpSession session, String userId) {
        // 이순간에 Session Binding이벤트가 일어나는 시점
        // name값으로 userId, value값으로 자기자신(HttpSessionBindingListener를 구현하는 Object)
        session.setAttribute(userId, this);// login에 자기자신을 집어넣는다.
    }

}
