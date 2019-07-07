package com.swing.saver.web.util;

import com.swing.saver.web.exception.ApiException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.net.ssl.*;
import java.net.URL;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

/**
 * Created by mycom on 2019-05-14.
 */
@Component
public class UrlConnectionUtil {
    private static final Logger LOGGER = LoggerFactory.getLogger("UrlConnectionUtil.class");


    public HttpsURLConnection getSslConnection(String endPoint, int timeout) throws ApiException {

        HttpsURLConnection httpURLConnection = null;
        URL url = null;
        try {
            // Open HTTPS connection
            url = new URL(endPoint);
            sslCheck();
            httpURLConnection = (HttpsURLConnection) url.openConnection();

            //헤더 정보 셋팅
            httpURLConnection.setConnectTimeout(timeout * 1000);      // 3 sec
            httpURLConnection.setReadTimeout(timeout * 1000);         // 3 sec

            httpURLConnection.setDoOutput(true);
            httpURLConnection.setDoInput(true);

            return httpURLConnection;
        } catch (Exception e) {
            throw new ApiException(endPoint+",HTTPSConnection Error!! ,"+e.getMessage());
        }
    }

    public static void sslCheck() throws Exception {
        HostnameVerifier hostnameVerifier = new HostnameVerifier() {
            @Override
            public boolean verify(String s, SSLSession sslSession) {
                return false;
            }
        };
        trustAllHttpsCertificates();
        HttpsURLConnection.setDefaultHostnameVerifier(hostnameVerifier);
    }

    private static void trustAllHttpsCertificates() throws Exception {
        TrustManager[] trustAllCerts = new TrustManager[1];
        TrustManager trustManager = new TrustAllCertificates();
        trustAllCerts[0] = trustManager;
        SSLContext sc = SSLContext.getInstance("SSL");
        sc.init(null, trustAllCerts, null);
        HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
    }

    private static class TrustAllHosts implements HostnameVerifier {
        public boolean verify(String hostname, SSLSession session) {
            return true;
        }
    }

    private static class TrustAllCertificates implements TrustManager,X509TrustManager {
        @Override
        public void checkClientTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
            return;
        }

        @Override
        public void checkServerTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
            return;
        }

        @Override
        public X509Certificate[] getAcceptedIssuers() {
            return null;
        }
    }
}
