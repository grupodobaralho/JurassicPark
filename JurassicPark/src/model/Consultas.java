package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class Consultas {

	//--1) Quantidade de espécies distintas
	public static void consultaA1(Connection connection) throws SQLException {
		String sql = "SELECT COUNT(DISTINCT dino.especie) qtd_especies " + 
					 "FROM tb_dinossauros dino";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);

		while (rs.next()) {
			int QTD_ESPECIES = rs.getInt("qtd_especies");			
			System.out.println(QTD_ESPECIES);
		}
		
		statement.close();
		rs.close();
	}
	
	//--2) Todos dinossauros do mais velho ao mais novo
	public static void consultaA2(Connection connection) throws SQLException {
		String sql = "SELECT dino.nome NOME, dino.especie ESPECIE, FLOOR((SYSDATE - dino.nascimento)/365) IDADE " + 
				 "FROM tb_dinossauros dino " + 
				 "ORDER BY IDADE DESC ";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		while (rs.next()) {
			String nome = rs.getString("nome");
			String especie = rs.getString("especie");
			int idade = rs.getInt("idade");			
			System.out.println(nome + "\t" + especie + "\t" + idade);
		}
		
		statement.close();
		rs.close();
		
	}
	
	//--3) Todas as espécies que não possuem 'sauro' no nome
	public static void consultaA3(Connection connection) throws SQLException {
		String sql = "SELECT DISTINCT dino.especie ESPECIE " + 
				 "FROM tb_dinossauros dino " + 
				 "WHERE dino.especie NOT LIKE '%sauro%' ";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		while (rs.next()) {			
			String especie = rs.getString("especie");			
			System.out.println(especie);
		}
		
		statement.close();
		rs.close();
		
	}	

		
	//B--3) Retorna os Eventos que possuem Tyranosaurus a partir da data e hora atual
		public static void consultaB3(Connection connection) throws SQLException {
			String sql = "SELECT dino.nome, atracao.nome EVENTO, area.nomearea AREA, TO_CHAR(evento.datahoraevento, 'dd/mm/yyyy hh24:mi') HORA, evento.qtdpublico CAPACIDADE " + 
					 "FROM tb_dinossauros dinoo " + 
					 " INNER JOIN tb_areas area ON dino.id_area = area.id_area " +
					 " INNER JOIN tb_areasatracoes evento ON area.id_area = evento.id_area " +
				" INNER JOIN tb_atracoes atracao ON atracao.id_atracao = evento.id_atracao " +
				" WHERE dino.nomeCientifico LIKE 'Tyrannosaurus%' AND evento.datahoraevento >= SYSDATE; ";
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(sql);
			
			while (rs.next()) {			
				String nome = rs.getString("nome");		
				String evento = rs.getString("evento");
				String area = rs.getString("area");
				String hora = rs.getString("hora");
				String capacidade = rs.getString("capacidade");
				System.out.println(nome + "\t" + evento + "\t" + area  + "\t" + hora + "\t" + capacidade);
			}
			
			statement.close();
			rs.close();
		}
	
}
	
