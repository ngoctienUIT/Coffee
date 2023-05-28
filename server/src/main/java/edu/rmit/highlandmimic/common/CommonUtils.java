package edu.rmit.highlandmimic.common;

import java.util.Objects;

public class CommonUtils {

    public static Object getOrDefault(Object value, Object defaultValue) {
        return Objects.isNull(value) ? defaultValue : value;
    }

}
