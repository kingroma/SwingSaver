package com.swing.saver.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.swing.saver.web.entity.Constant;
import com.swing.saver.web.entity.GroupVo;
import com.swing.saver.web.entity.LoginVo;
import com.swing.saver.web.entity.UserVo;
import com.swing.saver.web.exception.ApiException;
import com.swing.saver.web.service.RestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by mycom on 2019-06-03.
 */
@Controller
@RequestMapping(Constant.WEB_PREFIX)
public class WebController {

    private final static Logger LOGGER = LoggerFactory.getLogger(WebController.class);

    @Inject
    RestService restService;

    @GetMapping("/mypage")
    public ModelAndView myinfo(HttpSession session,ModelAndView mv) throws IOException, ApiException {
        LoginVo loginVo = (LoginVo)session.getAttribute("login");
        UserVo userVo = null;

        String sgrpRtnJson = "";
        long userId = loginVo.getUserid();
        /*회원정보 조회*/
        userVo = restService.getMemberInfo(userId);

        mv.addObject("userInfo",userVo);


        mv.setViewName("web/mypage_01");
        return mv;
    }
    
    @GetMapping("/search/{page}")
    public String search(@PathVariable String page){
        String viewPage ="";
        if(StringUtils.isEmpty(page)){
            viewPage = "index";
        }else if(page.equals("email")){
            viewPage = "web/log_04_01";
        }else if(page.equals("pw")){
            viewPage = "web/log_03_01_01";
        }else if(page.equals("pwreset")){
            viewPage = "web/log_03_01_02";
        }else if(page.equals("pwresetComp")){
            viewPage = "web/log_03_02_02";
        }

        return viewPage;
    }
    @PostMapping("/passwordReset")
    public ModelAndView passwordReset(@RequestBody Map<String, String> params) throws JsonProcessingException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("==================== WebController passwordReset Strart : ===================={}");
        String rtnJson = restService.passwordReset(params);
        mv.addObject("data",rtnJson);
        mv.setViewName("jsonView");
        LOGGER.debug("==================== WebController passwordReset end : ===================={}");
        return mv;
    }
    @GetMapping("/user/resetpassword/{key}")
    public ModelAndView getResetpassword(@PathVariable String key) throws IOException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("==================== WebController getResetpassword Strart : ===================={}");
        LOGGER.debug("confirmcode : {}",key);
        LOGGER.debug("==================== WebController getResetpassword end : ===================={}");

        mv.addObject("confirmcode",key);
        mv.setViewName("web/log_03_02_01");

        return  mv;
    }
    @PostMapping("/user/passwordProcess")
    public ModelAndView passwordProcess(@RequestBody Map<String, String> params) throws IOException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("==================== WebController passwordProcess Strart : ===================={}");
        String rtnJson = restService.passwordProcess(params);
        LOGGER.debug("==================== WebController passwordProcess end : ===================={}");

        mv.addObject("data",rtnJson);
        mv.setViewName("jsonView");
        return  mv;
    }
    @PostMapping("/emailSearch")
    public ModelAndView emailsearch(UserVo userVo, ModelAndView mv, HttpServletRequest request) throws ApiException, IOException {

        LOGGER.debug("==================== WebController emailsearch Strart : ===================={}");

        String rtnJson = restService.emailList(userVo);
        /*rtnJson="{\n" +
                "    \"emails\":[\n" +
                "        {\"email\":\"aaaa@bbb.com\"}\n" +
                "        ,{\"email\":\"aaaa3@bbb.com\"}\n" +
                "        ,{\"email\":\"aaaa4@abc.com\"}\n" +
                "    ]\n" +
                "}";*/
        LOGGER.debug("emailSearch rtn: {}",rtnJson);
        LOGGER.debug("==================== WebController emailsearch end : ===================={}");
        ObjectMapper mapper = new ObjectMapper();
        Map<Object,Object> map = new HashMap<Object, Object>();
        ArrayList list = new ArrayList();
        try {
            map = mapper.readValue(rtnJson, new TypeReference<Map<Object,Object>>(){});
            list = (ArrayList)map.get("emails");
        } catch (IOException e) {
            e.printStackTrace();
        }
        mv.addObject("emailList",list);
        mv.setViewName("web/log_04_02");
        return mv;
    }

    @GetMapping("/user/member")
    public ModelAndView memberForm(LoginVo loginVo, ModelAndView mv, HttpServletRequest request) throws ApiException, IOException {
        mv.setViewName("web/log_02_01");
        return mv;
    }
    @PostMapping("/user/join")
    public ModelAndView  memberjoin(@RequestBody Map<String, String> params) throws ApiException, IOException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("==================== WebController memberjoin Strart : ===================={}");

        String rtn = restService.join(params);

        /*회원가입 메일 발송*/
        ObjectMapper mapper = new ObjectMapper();
        Map<String, String> map = mapper.readValue(rtn, new TypeReference<Map<String, String>>(){});
        if(map.get("result").equals("true") && !StringUtils.isEmpty(map.get("confirmcode"))){
            LOGGER.debug("==================== WebController emailConfirm Strart : ===================={}");
            // rtn = restService.emailConfirm(map.get("confirmcode"));
            LOGGER.debug("==================== WebController emailConfirm End : ===================={}");
        }
        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("Map Join 파라미터:{},응답:{}",params.toString(),rtn);
        LOGGER.debug("==================== WebController memberjoin end : ===================={}");
        return mv;
    }

    @GetMapping("/user/joinSuccess")
    public String  memberjoinOk() {
        return "web/log_02_02";
    }

    @PostMapping("/user/modify")
    @ResponseBody
    public ModelAndView memberModify(@RequestBody Map<String, String> params, HttpServletRequest request) throws ApiException, IOException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("==================== WebController memberModify Strart : ===================={}");
        LOGGER.debug("Map Join :{}",params.toString());
        String rtn = restService.modify(params);

        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("==================== WebController memberModify end : ===================={}");
        return mv;
    }

    @GetMapping("/user/emailConfirm/{key}")
    public ModelAndView emailConfirm(@PathVariable String key) throws IOException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("==================== WebController emailConfirm Strart : ===================={}");
        String rtn = restService.emailConfirm(key);
        LOGGER.debug("==================== WebController emailConfirm end : ===================={}");
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = new HashMap<String, Object>();
        map = mapper.readValue(rtn, new TypeReference<Map<String, String>>(){});

        String page = "/";
        String msg = "회원 가입이 완료 처리 되었습니다.";
        if(!"true".equals(map.get("result").toString())){
            msg = "올바른 Key값이 아닙니다.";
        }
        mv.addObject("msg",msg);
        mv.addObject("url",page);
        mv.setViewName("web/alert");

        return  mv;
    }
    
    @PostMapping("/user/profileImgInsert")
    public ModelAndView profileImgInsert(@RequestBody Map<String, String> params, HttpServletRequest request) throws ApiException, IOException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("==================== WebController profileImgInsert Strart : ===================={}");
        LOGGER.debug("Map Join :{}",params.toString());
        String rtn = "" ;
        try {
        	rtn = restService.imgProfileInsert(params);
        }catch(Exception e) {
        	e.printStackTrace();
        }

        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("==================== WebController profileImgInsert end : ===================={}");
        return mv;
    }
}

