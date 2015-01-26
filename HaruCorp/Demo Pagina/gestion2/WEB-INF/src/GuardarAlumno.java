import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class GuardarAlumno implements Filter
{
	private DataSource fuenteDatos= null;
	String errorInicial = null;
	public void init(FilterConfig config) 
		throws ServletException
	{
		
		try {
			// recuperamos el contexto inicial y la referencia a la fuente de datos
			Context ctx = new InitialContext();
            fuenteDatos = (DataSource) ctx.lookup("java:comp/env/jdbc/bd_gestion_talleres");
        } catch (Exception e) {
            throw new ServletException("Imposible recuperar java:comp/env/jdbc/bd_gestion_talleres", e);
        }
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws java.io.IOException, ServletException
	{
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session=req.getSession(true);
		Connection con = null;
		
		
		try
		{
			con = fuenteDatos.getConnection();
			try
			{
				if(con == null)
				{
					throw new ServletException("---Problemas con la conexion");
				}
				String nombre = req.getParameter("nombre");
				String numBoleta = req.getParameter("boleta");
				String carrera = req.getParameter("carrera");
				String grupo = req.getParameter("grupo");
				if(nombre==null){
					chain.doFilter(request, response);
				}else{
					System.out.println("Preparando consulta");
					PreparedStatement prepStat = con.prepareStatement("INSERT INTO alumnos (num_boleta, nombre, carrera, grupo) VALUES(?,?,?,?)");
					prepStat.setString(1,numBoleta);
					prepStat.setString(2,nombre);
					prepStat.setString(3,carrera);
					prepStat.setString(4,grupo);
					prepStat.execute();
					System.out.println("Ejecutando consulta");
					String requestURI = req.getRequestURI();
					String toReplace = requestURI.substring(requestURI.indexOf("/") + 1, requestURI.length());
					String newURI = requestURI.replace(toReplace, "form_alumno.html");
					request.getRequestDispatcher(newURI).forward(request, response);
				}
				
				
			} catch (Exception e) {
				System.out.println("Error al procesar consulta " + e.getMessage());
			}
		} catch (Exception e) {
			System.out.println("Error al procesar la conexion "+e.getMessage());
		} finally { // pase lo que pase retornamos la conexion
			try
			{
				con.close();
			} catch (Exception e) {
				System.out.println("Error en proceso " + e.getMessage());
			}
		}
	}

	public void destroy()
	{}
}
