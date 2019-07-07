package com.swing.saver.web.entity;

/**
 * Created by mycom on 2019-06-04.
 */
public class BaseEntity {

    private String email;
    private String password;
    private String password4web;
    private String accessToken;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword4web() {
        return password4web;
    }

    public void setPassword4web(String password4web) {
        this.password4web = password4web;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

}
