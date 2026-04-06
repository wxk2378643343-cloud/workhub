package com.workhub.util;

import org.apache.commons.codec.digest.DigestUtils;

public final class Md5Util {
    private Md5Util() {
    }

    public static String md5(String source) {
        return DigestUtils.md5Hex(source);
    }
}
