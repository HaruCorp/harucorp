import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class LogFilter implements Filter{
	
	public void init(FilterConfig config)throws ServletException{
		String titulo=config.getInitParameter("titulo");
		System.out.println("-------------------------------------------------");
		System.out.println("Nombre del Registro: "+ titulo);
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)throws ServletException, IOException{
		HttpServletRequest registro=(HttpServletRequest) request;
		String ipAddress = request.getRemoteAddr();
		String requestURI = registro.getRequestURI();
		System.out.println("["+new Date().toString()+"] - Recurso invocado: "+ requestURI+ " desde la ip: "+ ipAddress);
		chain.doFilter(request,response);
	}

	public void destroy(){
	}
}