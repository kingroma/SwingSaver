package com.swing.saver.web.controller;

import com.swing.saver.web.entity.Constant;
import com.swing.saver.web.util.UploadFileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;

/**
 * Created by mycom on 2019-06-10.
 */
@Controller
@RequestMapping(Constant.UPLOAD_PREFIX)
public class UploadController {
    private static final Logger LOGGER = LoggerFactory.getLogger(UploadController.class);

    @Resource(name = "uploadPath")
    private String uploadPath;

    @PostMapping(value="/uploadAjax", produces = "text/plain;charset=UTF-8")
    public ResponseEntity<String> uploadAjaxPOST(MultipartFile file) throws Exception {

        LOGGER.info("originalName:" + file.getOriginalFilename());
        LOGGER.info("size:" + file.getSize());
        LOGGER.info("contentType:" + file.getContentType());

        return new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.CREATED);
    }
}
