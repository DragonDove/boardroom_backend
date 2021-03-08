package top.dragondove.boardroom.exception;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.UnauthenticatedException;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import top.dragondove.boardroom.entity.Msg;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionHandler {

    public static final String DEFAULT_ERROR_VIEW = "error";

    @ExceptionHandler({UnauthenticatedException.class, UnauthorizedException.class, AuthorizationException.class})
    public ModelAndView unauthenticatedExceptionHandler(HttpServletRequest req, Exception e) {
        e.printStackTrace();
        if (req.getRequestURI().startsWith("/index") || req.getRequestURI().startsWith("/manage")) {
            return new ModelAndView("403");
        } else {
            ModelAndView mav = new ModelAndView(new MappingJackson2JsonView());
            mav.addObject(Msg.error("权限不足"));
            return mav;
        }
    }

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Msg defaultErrorHandler(HttpServletRequest req, Exception e) {
        e.printStackTrace();
        return Msg.error("异常: " + e.getMessage());
    }

}
