package com.swing.saver.web.service;

import com.swing.saver.web.exception.ApiException;
import com.swing.saver.web.util.UrlConnectionUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.net.ssl.HttpsURLConnection;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.SocketTimeoutException;

/**
 * Created by mycom on 2019-05-15.
 */
@Service("SendMessage")
public class SendMessageImpl implements SendMessage {
    private final static Logger LOGGER = LoggerFactory.getLogger(SendMessageImpl.class);

    @Autowired
    private UrlConnectionUtil urlConnectionUtil;

    @Value("${api.endpoint.url}")
    private String endPointUrl;

    @Value("${api.conn.timeout}")
    private int connTime;

    @Value("${oAuth.auth_type}")
    private String authType;

    @Value("${oAuth.api.key}")
    private String apiKey;

    @Override
    public String sendHttpsStr(String params, String apiPath, String method, String content, boolean oAuth) throws ApiException {
        OutputStream wr = null;
        BufferedReader br = null;
        HttpsURLConnection httpConn = null;
        String url = endPointUrl + apiPath;
        String json = "";
        LOGGER.debug("sendHttpsStr : {},{}", content,params);
        try {

            byte[] paramsBytes = params.getBytes("UTF-8");
            httpConn = urlConnectionUtil.getSslConnection(url, connTime);
            httpConn.setRequestMethod(method);

            httpConn.setRequestProperty("Content-Type", content);
            if(oAuth){
                httpConn.setRequestProperty("Authorization", authType +" "+apiKey);
            }
            wr = new DataOutputStream(httpConn.getOutputStream());

            wr.write(paramsBytes);
            wr.flush();
            wr.close();

            int responseCode = httpConn.getResponseCode();
            //LOGGER.info("apiPath:{} ,response Code={}, request:{}",url, responseCode,reqParam);
            if (responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(httpConn.getInputStream(),"UTF-8"));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(httpConn.getErrorStream(),"UTF-8"));
            }

            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            LOGGER.info("response ={}",response.toString());
            httpConn.disconnect();
            json = response.toString();

        } catch (SocketTimeoutException e){
            LOGGER.error("sendHttp SocketTimeoutException Error:{}", e.getStackTrace());
            throw new ApiException("sendHttp SocketTimeoutException: " + e);
        } catch (NullPointerException e) {
            LOGGER.error("sendHttp NullPointerException Error, Message :{}", e.getStackTrace());
            throw new ApiException("sendHttp NullPointerException: " + e);
        } catch (Exception e) {
            LOGGER.error("sendHttp Exception Error:{}, Message :{}", e.getStackTrace());
            throw new ApiException("sendHttp Error: " + e);
        }

        return json;
    }

    @Override
    public String sendHttpsStr(String apiPath, String method, String content, boolean oAuth) throws ApiException {
        OutputStream wr = null;
        BufferedReader br = null;
        HttpsURLConnection httpConn = null;
        String url = endPointUrl + apiPath;
        String json = "";
        LOGGER.debug("sendHttpsStr : {},", url);
        try {

            httpConn = urlConnectionUtil.getSslConnection(url, connTime);
            httpConn.setRequestMethod(method);

            if(oAuth){
                httpConn.setRequestProperty("Authorization", authType +" "+apiKey);
            }

            int responseCode = httpConn.getResponseCode();
            //LOGGER.info("apiPath:{} ,response Code={}, request:{}",url, responseCode,reqParam);
            if (responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(httpConn.getInputStream(),"UTF-8"));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(httpConn.getErrorStream(),"UTF-8"));
            }

            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            LOGGER.info("response ={}",response.toString());
            httpConn.disconnect();
            json = response.toString();

        } catch (SocketTimeoutException e){
            LOGGER.error("sendHttp SocketTimeoutException Error:{}", e.getStackTrace());
            throw new ApiException("sendHttp SocketTimeoutException: " + e);
        } catch (NullPointerException e) {
            LOGGER.error("sendHttp NullPointerException Error, Message :{}", e.getStackTrace());
            throw new ApiException("sendHttp NullPointerException: " + e);
        } catch (Exception e) {
            LOGGER.error("sendHttp Exception Error:{}, Message :{}", e.getStackTrace());
            throw new ApiException("sendHttp Error: " + e);
        }

        return json;
    }
}
