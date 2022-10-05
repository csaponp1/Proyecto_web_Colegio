<%-- 
    Document   : index
    Created on : 2/10/2022, 13:19:59
    Author     : Sapón Pérez
--%>
<%@page import="Modelo.Estudiante1" %>
<%@page import="java.util.HashMap" %>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    </head>
    <body>
        
        <div class="container">
        <header style="background-color: yellow;padding-bottom: 20px">
            <h1>Formulario alumnos</h1>
        </header>
        <!<!-- Empieza el formulario de alumnos -->
        
        <ul class="nav nav-tabs">
            <li class="nav-item">
              <a class="nav-link active" href="index.jsp">Inicio</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="menu2.html" >Sobre Nosotros</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="menu3.html" >Galeria</a>
            </li>
            <li class="nav-item">
                
                <div class="btn-group">
                <button type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown">Submenu</button>
                <div class="dropdown-menu">
                <a class="dropdown-item" href="#">Trabaja con nosotros</a>
                <a class="dropdown-item" href="#">Se parte de nuestro equipo!</a>
                </div>
                </div>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Relax.FM</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Iniciar</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Cerrar</a>
            </li>
        </ul>
        
         <!-- Login -->
        <br>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalEstudiante" onclick="cls()">
            Agregar
        </button>
        
        <div class="modal fade" id="modalEstudiante" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                <div class="modal-body">
                    <div>
                        <form action="sr_estudiante" method="post" class="form-group">
                        <label for="lbl_id"><b>ID</b></label>
                        <input type="text" name="txt_id" id="txt_id" class="form-control" readonly="" value="0">

                        <label for="lbl_codigo"><b>Carnet</b></label>
                        <input type="text" name="txt_carnet" id="txt_carnet" class="form-control" placeholder="Ejemplo E0001" required>

                        <label for="lbl_nombres"><b>Nombres</b></label>
                        <input type="text" name="txt_nom" id="txt_nom" class="form-control" placeholder="Ejemplo: Byron Allan">

                        <label for="lbl_ape"><b>Apellidos</b></label>
                        <input type="text" name="txt_ape" id="txt_ape" class="form-control" placeholder="Ejemplo: Brito Delgado">

                        <label for="lbl_dir"><b>Direccion</b></label>
                        <input type="text" name="txt_dir" id="txt_dir" class="form-control" placeholder="Ejemplo: Ciudad zona pais">

                        <label for="lbl_tel"><b>Telefono</b></label>
                        <input type="number" name="txt_tel" id="txt_tel" placeholder="Ejemplo> 33333333" class="form-control" >
                        
                        <label for="lbl_email"><b>Correo Electronico</b></label>
                        <input type="text" name="txt_email" id="txt_email" class="form-control" placeholder="Ejemplo:ejemplo1@gmail.com">
                        
                        <label for="lbl_sangre"><b>Sangre</b></label>
                        <select name ="drop_sangre" id="drop_sangre" class="form-select">
                            <%
                                Estudiante1 obj1 = new Estudiante1();
                                HashMap<String,String> drop = obj1.drop_sangre();
                                for(String i:drop.keySet()){
                                    out.println("<option value='" +i+ "'>" +drop.get(i)+ "</option>");
                                }

                            %>
                            
                        </select>

                        <label for="lbl_fn"><b>Fecha nacimiento</b></label>
                        <input type="date" name="date_fn" id="date_fn" class="form-control">
                        
                
                        <br><button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Agregar</button>
                            <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
                            <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger" onclick="javascript:if(!confirm('¿Desea Eliminar?'))return false" >Eliminar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    
                        </form>
                    </div>
                </div>
            </div>
        </div>
       </div>
        
        
        <div>
            <br>
            <table class="table table-dark table-striped">
                <thead>
                  <tr>
                    <th>Carnet</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>Direccion</th>
                    <th>Telefono</th>
                    <th>Correo Electronico</th>
                    <th>Fecha nacimiento</th>
                    <th>Sangre</th>
                  </tr>
                </thead>
                <tbody id="tbl_estudiantes">
                    <%
                                Estudiante1 estudiante = new Estudiante1();
                                DefaultTableModel tabla = new DefaultTableModel();
                                tabla=estudiante.leer();
                                for(int t = 0; t<tabla.getRowCount();t++){
                                    out.println("<tr data-id="+tabla.getValueAt(t, 0)+" data-id_sangre="+tabla.getValueAt(t,9)+">");
                                    out.println("<td>"+tabla.getValueAt(t, 1)+"</td>");
                                    out.println("<td>"+tabla.getValueAt(t, 2)+"</td>");
                                    out.println("<td>"+tabla.getValueAt(t, 3)+"</td>");
                                    out.println("<td>"+tabla.getValueAt(t, 4)+"</td>");
                                    out.println("<td>"+tabla.getValueAt(t, 5)+"</td>");
                                    out.println("<td>"+tabla.getValueAt(t, 6)+"</td>");
                                    out.println("<td>"+tabla.getValueAt(t, 7)+"</td>");
                                    out.println("<td>"+tabla.getValueAt(t, 8)+"</td>");
                                    out.println("</tr>");
                                }
                            %>
                
                </tbody>
              </table>
        </div>
        
        <footer>
            <div>
                
                 <nav class="navbar navbar-expand-sm bg-light justify-content-center">
                     <ul class="nav nav-tabs">
                         <li class="nav item"><a class="nav-link" href="#"> Quienes Somos </a></li>
                         <li class="nav item"> <a class="nav-link" href="#"> Siguenos en Twitter</a> </li>
                         <li class="nav item"> <a class="nav-link" href="#"> Siguenos en Tiktok </a></li>
                     </ul>
                 </nav>     
            </div>
            <p>
                Creado por Christian Sapon (c) 2022
            </p>
        </footer>
        
        </div>
        
        
        
        
        
        
        
        <script src="https://code.jquery.com/jquery-3.6.1.slim.js" integrity="sha256-tXm+sa1uzsbFnbXt8GJqsgi2Tw+m4BLGDof6eUPjbtk=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script type="text/javascript">
            $('#tbl_estudiantes').on('click','tr td',function(evt){
                var target,id,id_s,carnet,nombres,apellidos,direccion,telefono,email,nacimiento;
                target = $(event.target);
                id= target.parent().data('id');
                id_s= target.parent().data('id_sangre');
                carnet = target.parent("tr").find("td").eq(0).html();
                
                nombres = target.parent("tr").find("td").eq(1).html();
                apellidos = target.parent("tr").find("td").eq(2).html();
                direccion = target.parent("tr").find("td").eq(3).html();
                telefono = target.parent("tr").find("td").eq(4).html();
                email = target.parent("tr").find("td").eq(5).html();
                nacimiento = target.parent("tr").find("td").eq(6).html();
                $("#txt_id").val(id);
                $("#txt_carnet").val(carnet);
                $("#txt_nom").val(nombres);
                $("#txt_ape").val(apellidos);
                $("#txt_dir").val(direccion);
                $("#txt_tel").val(telefono);
                $("#txt_email").val(email);
                $("#date_fn").val(nacimiento);
                $("#drop_sangre").val(id_s);
                $("#modalEstudiante").modal('show');

            });
         </script>
         <script>
             function cls(){
                 $("#txt_id").val(0);
                 $("#txt_carnet").val('');
                 $("#txt_nom").val('');
                 $("#txt_ape").val('');
                 $("#txt_dir").val('');
                 $("#txt_tel").val('');
                 $("#txt_email").val('');
                 $("#date_fn").val('');
                 $("#drop_sangre").val(1);
                 
             }
         </script>
         
    </body>
</html>
