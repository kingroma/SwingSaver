package com.swing.saver.web.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.swing.saver.web.entity.GroupVo;
import com.swing.saver.web.entity.LoginVo;
import com.swing.saver.web.entity.UserVo;
import com.swing.saver.web.exception.ApiException;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

/**
 * Created by mycom on 2019-05-29.
 */
public interface RestService {

    public LoginVo loginProcess(LoginVo loginVo, HttpSession session) throws ApiException, IOException;
    public String emailList(UserVo userVo) throws ApiException, IOException;
    public String oAuthToken();
    public String join(Map<String,String> joinMap) throws ApiException, JsonProcessingException;

    public UserVo getMemberInfo(long userId) throws ApiException, IOException;

    public String modify(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String emailConfirm(String key) throws JsonProcessingException, ApiException;

    public GroupVo getUserGroupInfo(String groupId) throws ApiException, IOException;

    public String groupCreate(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String grpMemberCreate(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String groupModify(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String getGroupMember(String groupId) throws ApiException;

    public String getSubGroup(String groupId) throws ApiException;

    public String getSubGroupMembers(String sid) throws ApiException;

    public String subGroupInsert(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String subGroupUpdate(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String subGroupDelete(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String subGroupUserDelete(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String subGroupUserMove(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String groupUserDelete(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String passwordReset(Map<String, String> params) throws JsonProcessingException, ApiException;

    public String passwordProcess(Map<String, String> params) throws JsonProcessingException, ApiException;
    
    public String imgProfileInsert(Map<String,String> params) throws JsonProcessingException, ApiException;
}
