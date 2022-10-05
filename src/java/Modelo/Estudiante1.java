/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Modelo;
import java.awt.HeadlessException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;



/**
 *
 * @author Sapón Pérez
 */
public class Estudiante1 extends Persona1{
    
    private Conexion cn;
    private String carnet,email;
    

    public Estudiante1(){};

    public Estudiante1(String carnet, String email, int id, String nombres, String apellidos, String fecha_nacimiento, String telefono, int id_sangre, String direccion) {
        super(id, nombres, apellidos, fecha_nacimiento, telefono, id_sangre, direccion);
        this.carnet = carnet;
        this.email = email;
    }
    
      public String getCarnet() {
        return carnet;
    }

    public void setCarnet(String carnet) {
        this.carnet = carnet;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    
    @Override
    public int agregar(){
        int retorno;
        try{
            PreparedStatement parametro;
            
            cn = new Conexion();
            cn.abrir_conexion();
            String query;
            query = "INSERT INTO estudiantes (carnet,nombres,apellidos,direccion,telefono,correo_electronico,id_tipo_sangre,fecha_nacimiento) VALUES (?,?,?,?,?,?,?,?);";
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setString(1, getCarnet());
            parametro.setString(2, getNombres());
            parametro.setString(3, getApellidos());
            parametro.setString(4, getDireccion());
            parametro.setString(5, getTelefono());
            parametro.setString(6, getEmail());
            parametro.setInt(7, getId_sangre());
            parametro.setString(8, getFecha_nacimiento());
            
            
            retorno = parametro.executeUpdate();
            
            cn.cerrar_conexion();
            
            
        }
            
        catch(SQLException ex){
            System.out.println("xxxx Error xxxx"+ ex.getMessage());
            retorno = 0;
        }
        
        cn.cerrar_conexion();
        return retorno;
    }
    

    
     public DefaultTableModel leer(){
      DefaultTableModel tabla = new DefaultTableModel();
      try{
          cn = new Conexion();
          cn.abrir_conexion();
            String query;
            query = "select e.id_estudiante as id, e.carnet,e.nombres,e.apellidos,e.direccion,e.telefono,e.correo_electronico,e.fecha_nacimiento,s.sangre,e.id_tipo_sangre from estudiantes as e inner join tipos_sangre as s on e.id_tipo_sangre = s.id_tipo_sangre order by id_estudiante;";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"id","carnet","nombres","apellidos","direccion","telefono","e-mail","fecha_nacimiento","sangre","id_sangre"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[10];
            
            while(consulta.next()){
                datos[0]=consulta.getString("id");
                datos[1]=consulta.getString("carnet");
                datos[2]=consulta.getString("nombres");
                datos[3]=consulta.getString("apellidos");
                datos[4]=consulta.getString("direccion");
                datos[5]=consulta.getString("telefono");
                datos[6]=consulta.getString("correo_electronico");
                datos[7]=consulta.getString("fecha_nacimiento");
                datos[8]=consulta.getString("sangre");
                datos[9]=consulta.getString("id_tipo_sangre");
                tabla.addRow(datos);
            }
          cn.cerrar_conexion();

      }catch(SQLException ex){

           System.out.println("error" + ex.getMessage());
      }

      return tabla;
  }
    
   
    @Override
    public int modificar(){
         int retorno;
        try{
            
            PreparedStatement parametro;
            cn = new Conexion();
            String query;
            query = "update estudiantes set carnet=?, nombres=?,apellidos=?,direccion=?,telefono=?,correo_electronico=?,id_tipo_sangre=?,fecha_nacimiento=? where id_estudiante=?;";   
            cn.abrir_conexion();
            
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            
            parametro.setString(1, getCarnet());
            parametro.setString(2, getNombres());
            parametro.setString(3, getApellidos());
            parametro.setString(4, getDireccion());
            parametro.setString(5, getTelefono());
            parametro.setString(6, getEmail());
            parametro.setInt(7, getId_sangre());
            parametro.setString(8, getFecha_nacimiento());
            parametro.setInt(9, getId());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
            
                
        }
        
        catch(HeadlessException | SQLException ex){
            System.out.println("error"+ex.getMessage());
            retorno = 0;
        }
    return retorno;
    
    }
    
     
    @Override
    public int eliminar(){
        int retorno;
        try{
        PreparedStatement parametro;
        cn = new Conexion();
        cn.abrir_conexion();
        String query;
        query = "delete from estudiantes where id_estudiante =?;";
        parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
        parametro.setInt(1, this.getId());
        retorno = parametro.executeUpdate();
        cn.cerrar_conexion();
        
        }
        catch(HeadlessException | SQLException ex){
            System.out.println("xxx Error xxxx"+ex.getMessage());
            retorno=0;
        } 
        return retorno;
    }
    
     
     public HashMap drop_sangre(){
         HashMap<String,String> drop = new HashMap();
         try{
             cn = new Conexion();
             String query = "select id_tipo_sangre as id, sangre from tipos_sangre;";
             cn.abrir_conexion();
             ResultSet consulta=cn.conexionBD.createStatement().executeQuery(query);
             while(consulta.next()){
                 drop.put(consulta.getString("id"),consulta.getString("sangre"));
             }
             
             cn.cerrar_conexion();
             
             
         }catch(SQLException ex){
             System.out.println("XXXXXXerrorXXXXXXX"+ex.getMessage());
         }
         return drop;
     }
  
}
