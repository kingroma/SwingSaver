package com.swing.saver.web.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;
import com.swing.saver.web.entity.*;
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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by mycom on 2019-06-09.
 */
@Controller
@RequestMapping(Constant.GRP_PREFIX)
public class GroupController {
    private final static Logger LOGGER = LoggerFactory.getLogger(GroupController.class);

    @Inject
    RestService restService;

    @GetMapping("/grpenter")
    public ModelAndView group(HttpSession session){
        LoginVo loginVo = (LoginVo) session.getAttribute("login");
        ModelAndView mv = new ModelAndView();
        String groupAdminYn = loginVo.getGroupadmin();
        String groupMember = loginVo.getGroupmember();
        if(groupAdminYn.equals("Y")){
            mv.setViewName("forward:/group/mygroup");
        }else {
            mv.setViewName("web/g_reg_01");//그룹 및 멤버 신청
        }
        return mv;
    }

    @GetMapping("/mygroup")
    public ModelAndView groupModify(HttpSession session) throws IOException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("GroupController mygroup 시작");
        LoginVo loginVo = (LoginVo) session.getAttribute("login");
        GroupVo groupVo = null;
        /*그룹정보조회*/
        String groupadminYn = loginVo.getGroupadmin();
        String groupId = loginVo.getGroupid();
        LOGGER.debug("그룹여부: {}",groupadminYn);
        /*그룹관리자 여부 및 그룹id 확인 없으면 회원정보 페이지로 이동*/
        if(groupadminYn.equals("Y") && !StringUtils.isEmpty(groupId)){
            groupVo = restService.getUserGroupInfo(groupId);
            mv.addObject("groupInfo",groupVo);
            mv.setViewName("web/g_info_01");
        }else{
            mv.setViewName("forward:/web/mypage");
        }

        LOGGER.debug("GroupController mygroup 종료");
        return mv;
    }

    @GetMapping("/grpcreate")
    public ModelAndView groupCreate(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("web/g_reg_01_01");
        return mv;
    }
    @GetMapping("/grpmember")
    public ModelAndView groupMemberCreate(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("web/g_reg_02_01");
        return mv;
    }

    @PostMapping("/insertGroup")
    public ModelAndView insertGroup(@RequestBody Map<String, String> params) throws JsonProcessingException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("GroupController insertGroup 시작");
        String rtn = restService.groupCreate(params);
        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("GroupController insertGroup 종료");
        return mv;
    }
    @PostMapping("/updateGroup")
    public ModelAndView updateGroup(@RequestBody Map<String, String> params) throws JsonProcessingException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("GroupController updateGroup 시작");
        String rtn = restService.groupModify(params);
        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("GroupController updateGroup 종료");
        return mv;
    }
    @GetMapping("/groupSuccess/{code}")
    public ModelAndView groupSuccess(@PathVariable String code){
        ModelAndView mv = new ModelAndView();
        mv.addObject("groupCode",code);
        mv.setViewName("web/g_reg_01_02");
        return mv;
    }

    @PostMapping("/insertGrpMmeber")
    public ModelAndView insertGrpMmeber(@RequestBody Map<String, String> params) throws JsonProcessingException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("GroupController insertGrpMmeber 시작");
        String rtn = restService.grpMemberCreate(params);
        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("GroupController insertGrpMmeber 종료");
        return mv;
    }

    @GetMapping("/groupMemberSucc")
    public ModelAndView groupSuccess(){
        ModelAndView mv = new ModelAndView();

        mv.setViewName("web/g_reg_02_02");
        return mv;
    }
    @GetMapping("/groupmember")
    public ModelAndView getGroupMember(HttpSession session) throws ApiException, IOException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("GroupController getGroupMember 시작");
        LoginVo loginVo = (LoginVo) session.getAttribute("login");
        String groupId = loginVo.getGroupid();

        /*그룹정보 조회*/
        GroupVo groupVo = restService.getUserGroupInfo(groupId);
        mv.addObject("groupInfo",groupVo);

        /*그룹멤버 조회*/
        String rtnJson = restService.getGroupMember(groupId);

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = mapper.readValue(rtnJson, new TypeReference<Map<String, Object>>(){});

        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,false);

        List<UserVo> memberList = mapper.convertValue(map.get("groupmembers"), TypeFactory.defaultInstance().constructCollectionType(List.class,UserVo.class));

        mv.addObject("memberList",memberList);
        mv.setViewName("web/g_mem_01");


        LOGGER.debug("GroupController getGroupMember 끝",memberList.toString());
        return mv;
    }
    @GetMapping("/subgroup")
    public ModelAndView getSubGroupMng(HttpSession session) throws IOException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("GroupController getSubGroupMng 시작");
        LoginVo loginVo = (LoginVo) session.getAttribute("login");
        String groupId = loginVo.getGroupid();

        /*그룹정보 조회*/
        GroupVo groupVo = restService.getUserGroupInfo(groupId);
        mv.addObject("groupInfo",groupVo);

        /*서브 그룹 조회*/
        String rtnJson = restService.getSubGroup(groupId);

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = mapper.readValue(rtnJson, new TypeReference<Map<String, Object>>(){});

        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,false);

        List<SubGroupVo> subGroupList = mapper.convertValue(map.get("subgroups"), TypeFactory.defaultInstance().constructCollectionType(List.class,SubGroupVo.class));
        mv.setViewName("web/g_sub_01");
        mv.addObject("subGroupList",subGroupList);

        LOGGER.debug("GroupController getSubGroupMng 끝",subGroupList.toString());
        return mv;
    }
    @GetMapping("/subgroup/subGrpCreate")
    public ModelAndView subGroupCreate(HttpSession session) throws IOException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("GroupController getSubGroupMng 시작");
        LoginVo loginVo = (LoginVo) session.getAttribute("login");
        String groupId = loginVo.getGroupid();

        /*그룹정보 조회*/
        GroupVo groupVo = restService.getUserGroupInfo(groupId);
        mv.addObject("groupInfo",groupVo);

        /*그룹멤버 조회*/
        String rtnJson = restService.getGroupMember(groupId);
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = mapper.readValue(rtnJson, new TypeReference<Map<String, Object>>(){});

        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,false);

        List<UserVo> memberList = mapper.convertValue(map.get("groupmembers"), TypeFactory.defaultInstance().constructCollectionType(List.class,UserVo.class));

        mv.addObject("memberList",memberList);

        mv.setViewName("web/g_sub_01_01");
        return mv;
    }
    @GetMapping("/subgroup/subGrpDetail/{sid}")
    public ModelAndView subGroupDeaail(HttpSession session,@PathVariable String sid) throws IOException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("GroupController subGrpDetail 시작");
        LoginVo loginVo = (LoginVo) session.getAttribute("login");
        String groupId = loginVo.getGroupid();
        LOGGER.info(">>"+groupId+"");
        /*그룹정보 조회*/
        GroupVo groupVo = restService.getUserGroupInfo(groupId);
        mv.addObject("groupInfo",groupVo);

        /*서브그룹 정보 및 멤버 정보 조회*/
        String rtnJson = restService.getSubGroupMembers(sid);

        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = mapper.readValue(rtnJson, new TypeReference<Map<String, Object>>(){});

        LOGGER.debug("GroupController Map : {}",map.toString());
        mv.addObject("subGroupInfo",map);
        
        /*서브 그룹 조회*/
        rtnJson = restService.getSubGroup(groupId);

        ObjectMapper _mapper = new ObjectMapper();
        Map<String, Object> _map = mapper.readValue(rtnJson, new TypeReference<Map<String, Object>>(){});

        _mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,false);

        List<SubGroupVo> subGroupList = _mapper.convertValue(_map.get("subgroups"), TypeFactory.defaultInstance().constructCollectionType(List.class,SubGroupVo.class));

        mv.addObject("subGroupList",subGroupList);

        mv.setViewName("web/g_sub_02_01");
        LOGGER.debug("GroupController subGrpDetail 끝");
        return mv;
    }

    @PostMapping("/subgroup/subGroupInsert")
    public ModelAndView subGroupInsert(@RequestBody Map<String, String> params) throws JsonProcessingException, ApiException {
        ModelAndView mv = new ModelAndView();
        LOGGER.debug("GroupController subGroupInsert 시작");
        String rtn = restService.subGroupInsert(params);
        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("GroupController subGroupInsert 종료");
        return mv;
    }
    @PostMapping(value="/subgroup/subGroupModify")
    public ModelAndView subGroupModify(HttpServletRequest request,HttpSession session) throws IOException, ApiException {
        ModelAndView mv = new ModelAndView();
        Map<String,String> subgrpmap = new HashMap<String, String>();

        LOGGER.debug("GroupController subGroupModify 시작");
        LoginVo loginVo = (LoginVo) session.getAttribute("login");
        String groupId = loginVo.getGroupid();

        /*그룹정보 조회*/
        GroupVo groupVo = restService.getUserGroupInfo(groupId);
        mv.addObject("groupInfo",groupVo);

        subgrpmap.put("groupname",request.getParameter("groupname"));
        subgrpmap.put("subgroupid",request.getParameter("subgroupid"));
        subgrpmap.put("quota",request.getParameter("quota"));
        subgrpmap.put("userid",request.getParameter("userid"));
        subgrpmap.put("startdate",request.getParameter("startdate"));
        subgrpmap.put("enddate",request.getParameter("enddate"));
        subgrpmap.put("lastname",request.getParameter("lastname"));
        subgrpmap.put("firstname",request.getParameter("firstname"));

        mv.addObject("subGroupInfo",subgrpmap);

        /*그룹멤버 조회*/
        String rtnJson = restService.getGroupMember(groupId);
        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = mapper.readValue(rtnJson, new TypeReference<Map<String, Object>>(){});

        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES,false);

        List<UserVo> memberList = mapper.convertValue(map.get("groupmembers"), TypeFactory.defaultInstance().constructCollectionType(List.class,UserVo.class));

        mv.addObject("memberList",memberList);


        mv.setViewName("web/g_sub_02_02");
        LOGGER.debug("GroupController subGroupModify 끝");
        return mv;
    }
    @PostMapping("/subgroup/subGroupUpdate")
    public ModelAndView subGroupUpdate (@RequestBody Map<String, String> params) throws JsonProcessingException, ApiException {
        ModelAndView mv= new ModelAndView();
        LOGGER.debug("GroupController subGroupUpdate 시작");
        String rtn = restService.subGroupUpdate(params);
        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("GroupController subGroupUpdate 종료");
        return mv;
    }
    @PostMapping("/subgroup/subGroupDelete")
    public ModelAndView subGroupDelete(@RequestBody Map<String, String> params) throws JsonProcessingException, ApiException {
        ModelAndView mv= new ModelAndView();
        LOGGER.debug("GroupController subGroupDelete 시작");
        String rtn = restService.subGroupDelete(params);
        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("GroupController subGroupDelete 종료");
        return mv;
    }
    @PostMapping("/subgroup/subGroupUserDelete")
    public ModelAndView subGroupUserDelete(@RequestBody Map<String, String> params) throws JsonProcessingException, ApiException {
        ModelAndView mv= new ModelAndView();
        LOGGER.debug("GroupController subGroupUserDelete 시작");
        String rtn = restService.subGroupUserDelete(params);
        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("GroupController subGroupUserDelete 종료");
        return mv;
    }
    @PostMapping("/subgroup/subGroupMove")
    public ModelAndView subGroupMove(@RequestBody Map<String, String> params) throws JsonProcessingException, ApiException {
        ModelAndView mv= new ModelAndView();
        LOGGER.debug("GroupController subGroupMove 시작");
        String rtn = restService.subGroupUserMove(params);
        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("GroupController subGroupMove 종료");
        return mv;
    }
    @PostMapping("/groupMemberDelete")
    public ModelAndView groupMemberDelete(@RequestBody Map<String, String> params) throws JsonProcessingException, ApiException {
        ModelAndView mv= new ModelAndView();
        LOGGER.debug("GroupController groupMemberDelete 시작");
        String rtn = restService.groupUserDelete(params);
        mv.addObject("data",rtn);
        mv.setViewName("jsonView");
        LOGGER.debug("GroupController groupMemberDelete 종료");
        return mv;
    }
}
