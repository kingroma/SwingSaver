package com.swing.saver.web.entity;

import org.springframework.http.MediaType;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by mycom on 2019-06-04.
 */
public enum Constant {
    INCONSTANT;

    public static final String PERMISSION_AUTHENTICATED = "AUTH";
    public static final String ROOT_PREFIX = "";
    public static final String REST_PREFIX = "/rest";
    public static final String USER_PREFIX = "/user";
    public static final String WEB_PREFIX = "/web";
    public static final String UPLOAD_PREFIX = "/upload";
    public static final String GRP_PREFIX = "/group";
    public static final String ADMIN_PREFIX = "/admin";

    private static Map<String, MediaType> mediaMap;

    static {
        mediaMap = new HashMap<String, MediaType>();
        mediaMap.put("JPG", MediaType.IMAGE_JPEG);
        mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
        mediaMap.put("GIF", MediaType.IMAGE_GIF);
        mediaMap.put("PNG", MediaType.IMAGE_PNG);
    }//

    public static MediaType getMediaType(String type) {
        return mediaMap.get(type.toUpperCase());
    }//

}
