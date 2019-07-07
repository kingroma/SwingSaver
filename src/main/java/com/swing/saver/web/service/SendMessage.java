package com.swing.saver.web.service;

import com.swing.saver.web.exception.ApiException;

/**
 * Created by mycom on 2019-05-15.
 */

public interface SendMessage {
    public String sendHttpsStr(String params, String apiPath, String method, String content, boolean oAuth) throws ApiException;

    String sendHttpsStr(String s, String get, String s1, boolean b) throws ApiException;
}
