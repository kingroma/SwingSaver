package com.swing.saver.web.entity;

import java.util.List;
import java.util.Map;

/**
 * Created by mycom on 2019-06-09.
 */
public class UserVo {

    private String email;
    private String firstname;
    private String lastname;
    private String dob;

    private String phone;
    private String gender;
    private String photo;
    private int availablepoints;
    private int usedspace;
    private int storagespace;
    private long id;
    private long userid;
    private List<Map<String,String>> subgroups;
    private String membertype;
    private String status;
    private String gradecode;
    private String enddate;

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public int getAvailablepoints() {
        return availablepoints;
    }

    public void setAvailablepoints(int availablepoints) {
        this.availablepoints = availablepoints;
    }

    public int getUsedspace() {
        return usedspace;
    }

    public void setUsedspace(int usedspace) {
        this.usedspace = usedspace;
    }

    public int getStoragespace() {
        return storagespace;
    }

    public void setStoragespace(int storagespace) {
        this.storagespace = storagespace;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserid() {
        return userid;
    }

    public void setUserid(long userid) {
        this.userid = userid;
    }

    public List<Map<String, String>> getSubgroups() {
        return subgroups;
    }

    public void setSubgroups(List<Map<String, String>> subgroups) {
        this.subgroups = subgroups;
    }

    public String getMembertype() {
        return membertype;
    }

    public void setMembertype(String membertype) {
        this.membertype = membertype;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getGradecode() {
        return gradecode;
    }

    public void setGradecode(String gradecode) {
        this.gradecode = gradecode;
    }
}
