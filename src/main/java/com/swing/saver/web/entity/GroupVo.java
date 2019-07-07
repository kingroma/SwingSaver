package com.swing.saver.web.entity;

/**
 * Created by mycom on 2019-06-09.
 */
public class GroupVo {
    private String id;//get 받을때 groupid
    private String groupid;
    private String groupname;
    private String grouptype;
    private String address;
    private String phone;
    private int quota;
    private int storagespace;
    private String startdate;
    private String enddate;
    private int membercount;
    private String status;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGroupid() {
        return groupid;
    }

    public void setGroupid(String groupid) {
        this.groupid = groupid;
    }

    public String getGroupname() {
        return groupname;
    }

    public void setGroupname(String groupname) {
        this.groupname = groupname;
    }

    public String getGrouptype() {
        return grouptype;
    }

    public void setGrouptype(String grouptype) {
        this.grouptype = grouptype;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getQuota() {
        return quota;
    }

    public void setQuota(int quota) {
        this.quota = quota;
    }

    public int getStoragespace() {
        return storagespace;
    }

    public void setStoragespace(int storagespace) {
        this.storagespace = storagespace;
    }

    public String getStartdate() {
        return startdate;
    }

    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    public int getMembercount() {
        return membercount;
    }

    public void setMembercount(int membercount) {
        this.membercount = membercount;
    }
}
