package com.swing.saver.web.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by mycom on 2019-06-08.
 */
public class TestController {
    public static void main(String args[]){
        String str="{\n" +
                "    \"emails\":[\n" +
                "        {\"email\":\"aaaa@bbb.com\"}\n" +
                "        ,{\"email\":\"aaaa3@bbb.com\"}\n" +
                "        ,{\"email\":\"aaaa4@abc.com\"}\n" +
                "    ]\n" +
                "}";
        ObjectMapper mapper = new ObjectMapper();
        Map<Object,Object> map = new HashMap<Object, Object>();
        ArrayList list = new ArrayList();
        try {
            map = mapper.readValue(str, new TypeReference<Map<Object,Object>>(){});
            list = (ArrayList)map.get("emails");
            System.out.print(map.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }


    }
}
