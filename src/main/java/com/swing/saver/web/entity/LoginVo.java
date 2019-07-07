package com.swing.saver.web.entity;

/**
 * Created by mycom on 2019-06-04.
 */

public class LoginVo extends BaseEntity {

    private long userid;
    private String result;

    private String groupadmin;
    private String grouppro;
    private String groupmember;
    private String groupid;

    public long getUserid() {
        return userid;
    }

    public void setUserid(long userid) {
        this.userid = userid;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getGroupadmin() { return groupadmin; }

    public void setGroupadmin(String groupadmin) {
        this.groupadmin = groupadmin;
    }

    public String getGrouppro() {
        return grouppro;
    }

    public void setGrouppro(String grouppro) {
        this.grouppro = grouppro;
    }

    public String getGroupmember() {
        return groupmember;
    }

    public void setGroupmember(String groupmember) {
        this.groupmember = groupmember;
    }

    public String getGroupid() {
        return groupid;
    }

    public void setGroupid(String groupid) {
        this.groupid = groupid;
    }
}
