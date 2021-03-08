package top.dragondove.boardroom.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

@Data
public class Msg implements Serializable {

    private int code;

    private String msg;

    private Map<String, Object> extras;

    public static Msg success() {

        Msg msg = new Msg();
        msg.extras = new HashMap<>();
        msg.setCode(200);

        return msg;
    }

    public static Msg success(String message) {
        Msg msg = success();
        msg.setMsg(message);
        return msg;
    }

    public static Msg error() {
        Msg msg = new Msg();
        msg.extras = new HashMap<>();
        msg.setCode(-1);
        return msg;
    }

    public static Msg error(String message) {
        Msg msg = error();
        msg.setMsg(message);
        return msg;
    }

    public static Msg msg(int code, String message) {
        Msg msg = new Msg();
        msg.setCode(code);
        msg.setMsg(message);
        return msg;
    }

    public Msg addExtra(String key, Object value) {
        extras.put(key, value);
        return this;
    }


}
