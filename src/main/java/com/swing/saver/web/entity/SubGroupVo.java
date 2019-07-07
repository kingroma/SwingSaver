package com.swing.saver.web.entity;

import java.util.List;

/**
 * Created by mycom on 2019-06-11.
 */
public class SubGroupVo {
    private String id;//get 받을때 subGroupid
    private String groupid;
    private String groupname;
    private String firstname;
    private String lastname;


    private String startdate;
    private String enddate;
    private int membercount;
    private int quota;
    private String subgroupid;
    private List<UserVo> subgroupmembers;

    public int getQuota() {
        return quota;
    }

    public void setQuota(int quota) {
        this.quota = quota;
    }

    public String getSubgroupid() {
        return subgroupid;
    }

    public void setSubgroupid(String subgroupid) {
        this.subgroupid = subgroupid;
    }

    public List<UserVo> getSubgroupmembers() {
        return subgroupmembers;
    }

    public void setSubgroupmembers(List<UserVo> subgroupmembers) {
        this.subgroupmembers = subgroupmembers;
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
