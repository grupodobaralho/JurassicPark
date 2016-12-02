import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class Consultas {

	//--1) Quantidade de esp�cies distintas
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
	
	//--3) Todas as esp�cies que n�o possuem 'sauro' no nome
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
	
	//--4) Todas dinossaouros f�meas que pesam menos que 10000kg e n�o s�o herbivoras
		public static void consultaA4(Connection connection) throws SQLException {
			String sql = "SELECT * " + 
					 "FROM tb_dinossauros dino " + 
					 "WHERE dino.sexo like 'F' AND dino.peso < 10000 AND dino.dieta like 'H' ";
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(sql);
			
			while (rs.next()) {	
				int id_dino = rs.getInt("id_dino");
				int id_area = rs.getInt("id_area");
				String nome = rs.getString("nome");					
				String nomecientifico = rs.getString("nomecientifico");	
				String especie = rs.getString("especie");
				String sexo = rs.getString("sexo");	
				System.out.println(especie);
			}
			
			statement.close();
			rs.close();
			
		}	
		
	//--3) Retorna os Eventos que possuem Tyranosaurus a partir da data e hora atual
		public static void consultaB3(Connection connection) throws SQLException {
			String sql = "SELECT dino.nome, atracao.nome EVENTO, area.nomearea AREA, TO_CHAR(evento.datahoraevento, 'dd/mm/yyyy hh24:mi') HORA, evento.qtdpublico CAPACIDADE " + 
					 "FROM tb_dinossauros dinoo " + 
					 " INNER JOIN tb_areas area ON dino.id_area = area.id_area " +
					 " INNER JOIN tb_areasatracoes evento ON area.id_area = evento.id_area " +
				" INNER JOIN tb_atracoes atracao ON atracao.id_atracao = evento.id_atracao " +
				" WHERE dino.nomeCientifico like 'Tyranosaurus%' AND evento.datahoraevento >= SYSDATE; ";
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(sql);
			
			while (rs.next()) {			
				String especie = rs.getString("especie");			
				System.out.println(especie);
			}
			
			statement.close();
			rs.close();
		}
	
}
	
