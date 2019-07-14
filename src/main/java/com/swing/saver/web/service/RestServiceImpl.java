package com.swing.saver.web.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.swing.saver.web.entity.GroupVo;
import com.swing.saver.web.entity.LoginVo;
import com.swing.saver.web.entity.UserVo;
import com.swing.saver.web.exception.ApiException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.Base64.Encoder;

/**
 * Created by mycom on 2019-05-29.
 */
@Service
public class RestServiceImpl implements RestService {
    private final static Logger LOGGER = LoggerFactory.getLogger(RestServiceImpl.class);

    @Autowired
    private SendMessage sendMessage;

    @Value("${oAuth.grant_type}")
    private String grantType;

    @Resource(name = "uploadPath")
    private String uploadPath;
    
    @Override
    public LoginVo loginProcess(LoginVo loginVo, HttpSession session) throws ApiException, IOException {
        ObjectMapper mapper = new ObjectMapper();
        String json = "";
        String rtnJson = "";

        try {

            LOGGER.debug("authUser 시작:{}",json);
            rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(loginVo),"/ords/swing/saver/authenticate","POST", "application/json",false);

            loginVo = mapper.readValue(rtnJson,LoginVo.class);
            LOGGER.debug("authUser 시작:{}",rtnJson);

        } catch (JsonProcessingException e) {
            throw new ApiException(e.getMessage());
        }
        return loginVo;
    }

    @Override
    public String emailList(UserVo userVo) throws ApiException, IOException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";
        Map<String,String> map = new HashMap<String, String>();
        map.put("firstname",userVo.getFirstname());
        map.put("lastname",userVo.getLastname());
        map.put("dob",userVo.getDob());

        LOGGER.debug("emailList 시작:{}",map.toString());

        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(map),"/ords/swing/saver/email","POST", "application/json",false);
        LOGGER.debug("emailList 끝:{}",rtnJson);

        return rtnJson;
    }

    @Override
    public String oAuthToken() {

        String rtnJson = "";

        try {
            rtnJson = sendMessage.sendHttpsStr(grantType,"/ords/swing/oauth/token","POST", "application/x-www-form-urlencoded",true);

            LOGGER.debug("oAuthToken 파라미터:{},응답:{}",grantType,rtnJson);
        } catch (ApiException e) {
            e.printStackTrace();
        }

        return rtnJson;
    }

    @Override
    public String join(Map<String, String> joinMap) throws ApiException, JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(joinMap),"/ords/swing/saver/preuser","POST", "application/json",true);

        LOGGER.debug("회원 가입 파라미터:{},응답:{}",joinMap.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public UserVo getMemberInfo(long userId) throws ApiException, IOException {
        ObjectMapper mapper = new ObjectMapper();
        UserVo userVo = null;

        String rtnJson= "";
        String param = Long.toString(userId);
        rtnJson = sendMessage.sendHttpsStr("/ords/swing/saver/user4web/"+param,"GET", "application/json",true);
        LOGGER.debug("회원 정보 파라미터:{},응답:{}",param,rtnJson);
        userVo = mapper.readValue(rtnJson,UserVo.class);

        return userVo;
    }

    @Override
    public String modify(Map<String, String> params) throws ApiException,JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params),"/ords/swing/saver/user4web","PUT", "application/json",true);

        LOGGER.debug("회원 수정 파라미터:{},응답:{}",mapper.writeValueAsString(params),rtnJson);

        return rtnJson;
    }

    @Override
    public String emailConfirm(String key) throws JsonProcessingException, ApiException {
        ModelAndView mv = new ModelAndView();
        ObjectMapper mapper = new ObjectMapper();
        Map<String,String> map = new HashMap<String, String>();
        map.put("confirmCode",key);

        String rtnJson = "";
        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(map),"/ords/swing/saver/user","POST", "application/json",true);

        LOGGER.debug("회원 가입 인증Key 파라미터:{},응답:{}",mapper.writeValueAsString(map),rtnJson);

        return rtnJson;
    }

    @Override
    public GroupVo getUserGroupInfo(String groupId) throws ApiException, IOException {

        ObjectMapper mapper = new ObjectMapper();
        GroupVo groupVo = new GroupVo();

        String rtnJson= "";
        rtnJson = sendMessage.sendHttpsStr("/ords/swing/saver/group/"+groupId,"GET", "application/json",true);
        LOGGER.debug("회원 그룹 정보 파라미터:{},응답:{}",groupId,rtnJson);
        groupVo = mapper.readValue(rtnJson,GroupVo.class);

        return groupVo;
    }

    @Override
    public String groupCreate(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params),"/ords/swing/saver/group","POST", "application/json",true);

        LOGGER.debug("그룹 가입 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String grpMemberCreate(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params),"/ords/swing/saver/groupmember","POST", "application/json",true);

        LOGGER.debug("그룹 멤버 가입 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String groupModify(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params),"/ords/swing/saver/group","PUT", "application/json",true);

        LOGGER.debug("그룹 수정 파라미터:{},응답:{}",mapper.writeValueAsString(params),rtnJson);

        return rtnJson;
    }

    @Override
    public String getGroupMember(String groupId) throws ApiException {
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr("/ords/swing/saver/groupmembers/"+groupId,"GET", "application/x-www-form-urlencoded",true);

        LOGGER.debug("그룹 멤버 조회 파라미터:{},응답:{}",groupId.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String getSubGroup(String groupId) throws ApiException {
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr("/ords/swing/saver/subgroups/"+groupId,"GET", "application/x-www-form-urlencoded",true);

        LOGGER.debug("서브 그룹 조회 파라미터:{},응답:{}",groupId.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String getSubGroupMembers(String subgroupid) throws ApiException {
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr("/ords/swing/saver/subgroup/"+subgroupid,"GET", "application/x-www-form-urlencoded",true);

        LOGGER.debug("서브 그룹 상세 조회 파라미터:{},응답:{}",subgroupid.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String subGroupInsert(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params),"/ords/swing/saver/subgroup","POST", "application/json",true);

        LOGGER.debug("서브그룹 생성 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String subGroupUpdate(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params),"/ords/swing/saver/subgroup","PUT", "application/json",true);

        LOGGER.debug("서브그룹 수정 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String subGroupDelete(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";
        if(params.get("subgroupid").indexOf(",") == -1) {
            rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params), "/ords/swing/saver/subgroup", "DELETE", "application/json", true);
        }else{
            String[] subgrpList = params.get("subgroupid").split(",");
            Map<String,String> sendMap = new HashMap<String, String>();
            for (String str: subgrpList) {
                sendMap.clear();
                sendMap.put("subgroupid",str);
                rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(sendMap), "/ords/swing/saver/subgroup", "DELETE", "application/json", true);
            }

        }
        LOGGER.debug("서브그룹 삭제 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String subGroupUserDelete(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        if(params.get("userid").indexOf(",") == -1) {
            rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params), "/ords/swing/saver/subgroupmember", "DELETE", "application/json", true);
        }else{
            String[] useridList = params.get("userid").split(",");
            Map<String,Object> sendMap = new HashMap<String, Object>();
            for (String str: useridList) {
                sendMap.clear();
                sendMap.put("subgroupid",params.get("subgroupid"));
                sendMap.put("userid",Long.parseLong(str));
                rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(sendMap), "/ords/swing/saver/subgroupmember", "DELETE", "application/json", true);
            }

        }
        LOGGER.debug("서브그룹 멤버 삭제 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String subGroupUserMove(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        if(params.get("userid").indexOf(",") == -1) {
            rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params), "/ords/swing/saver/subgroupmember/move", "POST", "application/json", true);
        }else{
            String[] useridList = params.get("userid").split(",");
            Map<String,Object> sendMap = new HashMap<String, Object>();
            for (String str: useridList) {
                sendMap.clear();
                sendMap.put("sourceid",params.get("sourceid"));
                sendMap.put("targetid",params.get("targetid"));
                sendMap.put("userid",Long.parseLong(str));
                rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(sendMap), "/ords/swing/saver/subgroupmember/move", "POST", "application/json", true);
            }

        }
        LOGGER.debug("서브그룹 이동 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String groupUserDelete(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        if(params.get("userid").indexOf(",") == -1) {
            rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params), "/ords/swing/saver/groupmember", "DELETE", "application/json", true);
        }else{
            String[] useridList = params.get("userid").split(",");
            Map<String,Object> sendMap = new HashMap<String, Object>();
            for (String str: useridList) {
                sendMap.clear();
                sendMap.put("groupid",params.get("groupid"));
                sendMap.put("userid",Long.parseLong(str));
                rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(sendMap), "/ords/swing/saver/groupmember", "DELETE", "application/json", true);
            }

        }
        LOGGER.debug("서브그룹 이동 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;

    }

    @Override
    public String passwordReset(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params),"/ords/swing/saver/password/sendemail","POST", "application/json",true);

        LOGGER.debug("비밀번호 재설정 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;
    }

    @Override
    public String passwordProcess(Map<String, String> params) throws JsonProcessingException, ApiException {
        ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";

        rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params),"/ords/swing/saver/password","POST", "application/json",true);

        LOGGER.debug("비밀번호 재설정 완료 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;
    }
    
    public String imgProfileInsert(Map<String,String> params) throws JsonProcessingException, ApiException{
    	ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "{\"result\":\"true\"}";
        String url = "/ords/swing/saver/photo";
        
        LOGGER.debug("profile재설정 재설정 완료 파라미터:{},응답:{}",params.toString(),rtnJson);
        if(uploadPath != null && uploadPath.lastIndexOf("/") == uploadPath.length() -1 && uploadPath.length() > 0) {
        	uploadPath = uploadPath.substring(0,uploadPath.length()-1);
		}
        String sendPath = uploadPath + params.get("photo");
        
        File file = new File(sendPath);
        
        byte[] bytes = new byte[(int) file.length()]; 
        try {
        	FileInputStream fis = new FileInputStream(file);
    		fis.read(bytes); //read file into bytes[]
    		fis.close();
    		Encoder encoder = Base64.getEncoder();
    		String data = new String(encoder.encode(bytes));
    		params.put("photo",data);
    		rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(params),url,"POST", "application/json",true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
        
        return rtnJson;
    }
    
    private String getFile (String path) {
    	
    	return null;
    }
    
    /**
     * 그룹 승인 취소 요청
     * */
    public String groupMemberAcceptCancel(Map<String,String> params)throws JsonProcessingException, ApiException{
    	String[] useridList = params.get("userid").split(",");
        String[] membertypeList = params.get("membertype").split(",");
        String groupid = params.get("groupid");
        String status = params.get("status");
        
    	ObjectMapper mapper = new ObjectMapper();
        String rtnJson = "";
        
        //https://www.swingsaver.co.kr/ords/swing/saver/groupmember
        if(params.get("userid").indexOf(",") == -1) {
        	Map<String,Object> sendMap = new HashMap<String, Object>();
        	sendMap.put("groupid",groupid);
            sendMap.put("status",status);
            sendMap.put("userid",Long.parseLong(params.get("userid")));
            sendMap.put("membertype", params.get("membertype"));
            
            rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(sendMap), "/ords/swing/saver/groupmember", "PUT", "application/json", true);
        }else{
            
             
            Map<String,Object> sendMap = new HashMap<String, Object>();
            int i = 0 ;
            for (String str: useridList) {
                sendMap.clear();
                
                sendMap.put("groupid",groupid);
                sendMap.put("status",status);
                sendMap.put("userid",Long.parseLong(str));
                sendMap.put("membertype", membertypeList[i]);
                
                rtnJson = sendMessage.sendHttpsStr(mapper.writeValueAsString(sendMap), "/ords/swing/saver/groupmember", "PUT", "application/json", true);
                i ++;
            }

        }
        LOGGER.debug("그룹 승인 취소 파라미터:{},응답:{}",params.toString(),rtnJson);

        return rtnJson;
    }
}
