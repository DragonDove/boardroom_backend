package top.dragondove.boardroom.exception;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CustomException extends RuntimeException {

    private int code;
    private String msg;

}
