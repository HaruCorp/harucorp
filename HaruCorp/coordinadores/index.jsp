<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Coordinador</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

        <!--base css styles-->
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">

        <!--page specific css styles-->

        <!--flaty css styles-->
        <link rel="stylesheet" href="css/flaty.css">
        <link rel="stylesheet" href="css/flaty-responsive.css">

        <link rel="shortcut icon" href="img/favicon.png">
    </head>
    <body>

        <!-- BEGIN Theme Setting -->
        <div id="theme-setting">
            <a href="#"><i class="fa fa-gears fa fa-2x"></i></a>
            <ul>
                <li>
                    <span>Skin</span>
                    <ul class="colors" data-target="body" data-prefix="skin-">
                        <li class="active"><a class="blue" href="#"></a></li>
                        <li><a class="red" href="#"></a></li>
                        <li><a class="green" href="#"></a></li>
                        <li><a class="orange" href="#"></a></li>
                        <li><a class="yellow" href="#"></a></li>
                        <li><a class="pink" href="#"></a></li>
                        <li><a class="magenta" href="#"></a></li>
                        <li><a class="gray" href="#"></a></li>
                        <li><a class="black" href="#"></a></li>
                    </ul>
                </li>
                <li>
                    <span>Navbar</span>
                    <ul class="colors" data-target="#navbar" data-prefix="navbar-">
                        <li class="active"><a class="blue" href="#"></a></li>
                        <li><a class="red" href="#"></a></li>
                        <li><a class="green" href="#"></a></li>
                        <li><a class="orange" href="#"></a></li>
                        <li><a class="yellow" href="#"></a></li>
                        <li><a class="pink" href="#"></a></li>
                        <li><a class="magenta" href="#"></a></li>
                        <li><a class="gray" href="#"></a></li>
                        <li><a class="black" href="#"></a></li>
                    </ul>
                </li>
                <li>
                    <span>Sidebar</span>
                    <ul class="colors" data-target="#main-container" data-prefix="sidebar-">
                        <li class="active"><a class="blue" href="#"></a></li>
                        <li><a class="red" href="#"></a></li>
                        <li><a class="green" href="#"></a></li>
                        <li><a class="orange" href="#"></a></li>
                        <li><a class="yellow" href="#"></a></li>
                        <li><a class="pink" href="#"></a></li>
                        <li><a class="magenta" href="#"></a></li>
                        <li><a class="gray" href="#"></a></li>
                        <li><a class="black" href="#"></a></li>
                    </ul>
                </li>
                <li>
                    <span></span>
                    <a data-target="navbar" href="#"><i class="fa fa-square-o"></i> Fixed Navbar</a>
                    <a class="hidden-inline-xs" data-target="sidebar" href="#"><i class="fa fa-square-o"></i> Fixed Sidebar</a>
                </li>
            </ul>
        </div>
        <!-- END Theme Setting -->

        <!-- BEGIN Navbar -->
        <div id="navbar" class="navbar">
            <button type="button" class="navbar-toggle navbar-btn collapsed" data-toggle="collapse" data-target="#sidebar">
                <span class="fa fa-bars"></span>
            </button>
            <a class="navbar-brand" href="#">
                <small>
                    <i class="fa fa-desktop"></i>
                    Gesti&oacute;n de Talleres y Actividades Extracurriculares
                </small>
            </a>

            <!-- BEGIN Navbar Buttons -->
            <ul class="nav flaty-nav pull-right">
                <!-- BEGIN Button Tasks -->
                

                
                <!-- END Button Notifications -->

                <!-- BEGIN Button Messages -->
                
                <!-- END Button Messages -->

                <!-- BEGIN Button User -->
                <li class="user-profile">
                    <a data-toggle="dropdown" href="#" class="user-menu dropdown-toggle">
                        <span class="hhh" id="user_info">
                             <%
                                javax.sql.DataSource fuenteDatos = null;
                                String errorInicial = null;
                                String id="";
                                String nombre= null;
                                java.sql.Connection con = null;
                                response.setContentType("text/html");
                                id=request.getParameter("id_coordinador");

                                try {
                                            // recuperamos el contexto inicial y la referencia a la fuente de datos
                                            javax.naming.Context ctx = new javax.naming.InitialContext();
                                            fuenteDatos = (javax.sql.DataSource) ctx.lookup("java:comp/env/jdbc/bd_gestion_talleres");
                                } catch (Exception e) {
                                            throw new ServletException("Imposible recuperar java:comp/env/jdbc/bd_gestion_talleres", e);
                                }

                                try
                                {
                                    con = fuenteDatos.getConnection();
                                    try
                                    {
                                        if(con == null)
                                        {
                                            out.println("</br>Error al recuperar la conexion, es nula");
                                            throw new ServletException("---Problemas con la conexion");
                                        }
                                        java.sql.PreparedStatement prepStat1 = con.prepareStatement("SELECT nombre FROM coordinadores WHERE id_coordinador=?");
                                        int idaux=Integer.parseInt(id);
                                        prepStat1.setInt(1,idaux);
                                        java.sql.ResultSet resCons1 = prepStat1.executeQuery();
                                        while (resCons1.next())
                                        {
                                            String cam4 = resCons1.getString("nombre");
                                            nombre = cam4;
                                            out.write(cam4);
                                        }
                                        
                                    } catch (Exception e) {
                                        out.println("</br>Error al procesar consulta " + e.getMessage());
                                    }
                                } catch (Exception e) {
                                    out.println("<h3>Error al procesar la conexion "+e.getMessage()+"</h3>");
                                } finally { // pase lo que pase retornamos la conexion
                                    try
                                    {
                                        con.close();
                                    } catch (Exception e) {
                                        out.println("</br>Error en proceso " + e.getMessage());
                                    }
                                }
                                
                                
                            %>
                        </span>
                        <i class="fa fa-caret-down"></i>
                    </a>

                    <!-- BEGIN User Dropdown -->
                    <ul class="dropdown-menu dropdown-navbar" id="user_menu">

                        <li>
                            <a href="/gestion2/close">
                                <i class="fa fa-off"></i>
                                Cerrar sesi&oacute;n
                            </a>
                        </li>
                    </ul>
                    <!-- BEGIN User Dropdown -->
                </li>
                <!-- END Button User -->
            </ul>
            <!-- END Navbar Buttons -->
        </div>
        <!-- END Navbar -->

        <!-- BEGIN Container -->
        <div class="container" id="main-container">
            <!-- BEGIN Sidebar -->
            <div id="sidebar" class="navbar-collapse collapse">
                <!-- BEGIN Navlist -->
                <ul class="nav nav-list">
                    
                    <li class="active"><% 
                    out.println("<a href='index.jsp?id_coordinador="+id+"'>");%>
                            <i class="fa fa-dashboard"></i>
                            <span>Inicio</span>
                        </a>
                    </li>
                        <%
                                

                                try
                                {
                                    con = fuenteDatos.getConnection();
                                    try
                                    {
                                        if(con == null)
                                        {
                                            out.println("</br>Error al recuperar la conexion, es nula");
                                            throw new ServletException("---Problemas con la conexion");
                                        }
                                        java.sql.PreparedStatement prepStat = con.prepareStatement("SELECT id_actividad, nombre_actividad, modalidad FROM actividades WHERE id_coordinador=?");
                                        int idaux=Integer.parseInt(id);
                                        prepStat.setInt(1,idaux);
                                        java.sql.ResultSet resCons = prepStat.executeQuery();
                                        while (resCons.next())
                                        {
                                            String cam1 = resCons.getString("nombre_actividad");
                                            String cam2 = resCons.getString("id_actividad");
                                            String cam3 = resCons.getString("modalidad");
                                            if(cam3.equals("1")){
                                                out.write("<li><a href='#' class='dropdown-toggle'><i class='fa fa-edit'></i><span>"+cam1+"</span></a><ul class='submenu'><li><a href='tomar_lista.jsp?id_coordinador="+id+"&id="+cam2+"&modalidad="+cam3+"'>Tomar lista</a></li><li><a href='lista_alumno.jsp?id_coordinador="+id+"&id="+cam2+"'>Lista de alumnos</a></li><li><a href='agregar_alumno.jsp?id_coordinador="+id+"&id="+cam2+"&modalidad="+cam3+"'>Agregar alumno a la actividad</a></li><li><a href='reporte.jsp?id_coordinador="+id+"&id="+cam2+"&modalidad="+cam3+"'>Generar reporte</a></li></li></ul>");
                                            }else{
                                                out.write("<li><a href='#' class='dropdown-toggle'><i class='fa fa-edit'></i><span>"+cam1+"</span></a><ul class='submenu'><li><a href='agregar_trabajo.jsp?id_coordinador="+id+"&id="+cam2+"&modalidad="+cam3+"'>Agregar trabajo</a></li><li><a href='lista_alumno.jsp?id_coordinador="+id+"&id="+cam2+"'>Lista de alumnos</a></li><li><a href='agregar_alumno.jsp?id_coordinador="+id+"&id="+cam2+"&modalidad="+cam3+"'>Agregar alumno a la actividad</a></li><li><a href='reporte.jsp?id_coordinador="+id+"&id="+cam2+"&modalidad="+cam3+"'>Generar reporte</a></li></li></ul>");
                                            }
                                            
                                        }
                                        
                                    } catch (Exception e) {
                                        out.println("</br>Error al procesar consulta " + e.getMessage());
                                    }
                                } catch (Exception e) {
                                    out.println("<h3>Error al procesar la conexion "+e.getMessage()+"</h3>");
                                } finally { // pase lo que pase retornamos la conexion
                                    try
                                    {
                                        con.close();
                                    } catch (Exception e) {
                                        out.println("</br>Error en proceso " + e.getMessage());
                                    }
                                }
                                
                                
                            %>

                    
                </ul>
                <!-- END Navlist -->

                <!-- BEGIN Sidebar Collapse Button 
                <div id="sidebar-collapse" class="visible-lg">
                    <i class="fa fa-angle-double-left"></i>
                </div>
                <!-- END Sidebar Collapse Button -->
            </div>
            <!-- END Sidebar -->

            <!-- BEGIN Content -->
            <div id="main-content">
                <!-- BEGIN Page Title -->
                <div class="page-title">
                    <div>
                        <h1><i class="fa fa-file-o"></i> Bienvenid@:

                            <%
                                out.write(nombre);
                            %>

                        </h1>
                        <h4>Seleccione alguna de las opciones de la izquierda</h4>
                    </div>
                </div>
                <!-- END Page Title -->

                <!-- BEGIN portada -->
                <div id="portada" >
                    
                </div>
                <!-- END portada -->


                


                
                
                <footer>
                    <p>2014 - Unidad Profesional Interdisciplinaria de Ingenier&iacute;as Campus Zacatecas <br>by Haru Corp.</p>
                </footer>

                
            </div>
            <!-- END Content -->
        </div>
        <!-- END Container -->


        <!--basic scripts-->
        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="assets/jquery/jquery-2.0.3.min.js"><\/script>')</script>
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/jquery-slimscroll/jquery.slimscroll.min.js"></script>
        <script src="assets/jquery-cookie/jquery.cookie.js"></script>

        <!--page specific plugin scripts-->
        <script src="assets/flot/jquery.flot.js"></script>
        <script src="assets/flot/jquery.flot.resize.js"></script>
        <script src="assets/flot/jquery.flot.pie.js"></script>
        <script src="assets/flot/jquery.flot.stack.js"></script>
        <script src="assets/flot/jquery.flot.crosshair.js"></script>
        <script src="assets/flot/jquery.flot.tooltip.min.js"></script>
        <script src="assets/sparkline/jquery.sparkline.min.js"></script>

        <!--flaty scripts-->
        <script src="js/flaty.js"></script>
        <script src="js/flaty-demo-codes.js"></script>

    </body>
</html>
