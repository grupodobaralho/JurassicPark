package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class Consultas {
	//-----------------------------------------CONSULTAS A-----------------------------------------
	//--A1) Quantidade de espécies distintas
	public static void consultaA1(Connection connection) throws SQLException {
		String sql = "SELECT COUNT(DISTINCT dino.especie) qtd_especies " + 
					 "FROM tb_dinossauros dino";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);

		while (rs.next()) {
			int QTD_ESPECIES = rs.getInt("qtd_especies");			
			System.out.println("Consulta a1) Quantidade de espécies distintas: " + QTD_ESPECIES);
		}
		
		statement.close();
		rs.close();
	}
	
	//--A2) Todos dinossauros do mais velho ao mais novo
	public static void consultaA2(Connection connection) throws SQLException {
		String sql = "SELECT dino.nome NOME, dino.especie ESPECIE, FLOOR((SYSDATE - dino.nascimento)/365) IDADE " + 
				 "FROM tb_dinossauros dino " + 
				 "ORDER BY IDADE DESC";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta a2) Todos dinossauros do mais velho ao mais novo:");
		System.out.println("NOME, ESPÉCIE, IDADE");
		while (rs.next()) {
			String nome = rs.getString("nome");
			String especie = rs.getString("especie");
			int idade = rs.getInt("idade");			
			System.out.println(nome + ", " + especie + ", " + idade + " anos");
		}
		
		statement.close();
		rs.close();
	}
	
	//--A3) Todas as espécies que não possuem 'sauro' no nome
	public static void consultaA3(Connection connection) throws SQLException {
		String sql = "SELECT DISTINCT dino.especie ESPECIE " + 
				 "FROM tb_dinossauros dino " + 
				 "WHERE dino.especie NOT LIKE '%sauro%'";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta a3) Todas as espécies que não possuem 'sauro' no nome:");
		while (rs.next()) {			
			String especie = rs.getString("especie");			
			System.out.println(especie);
		}
		
		statement.close();
		rs.close();
	}	

	//--A4) Todas dinossaouros fêmeas que pesam menos que 10000kg e não são herbivoras
	public static void consultaA4(Connection connection) throws SQLException {
		String sql = "SELECT * " + 
				 "FROM tb_dinossauros dino " + 
				 "WHERE dino.sexo like 'F' AND dino.peso < 10000 AND dino.dieta like 'H'";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta a4) Todas dinossaouros fêmeas que pesam menos que 10000kg e não são herbivoras:");
		System.out.println("NOME, NOME_CIENTÍFICO, ESPÉCIE, SEXO, PESO, DIETA, ÉPOCA");
		while (rs.next()) {			
			String nome = rs.getString("nome");
			String nomeCientifico = rs.getString("nomecientifico");
			String especie = rs.getString("especie");
			String sexo = rs.getString("sexo");
			int peso = rs.getInt("peso");
			String dieta = rs.getString("dieta");
			String epoca = rs.getString("epoca");
			System.out.println(nome + ", " + nomeCientifico + ", " + especie + ", " + sexo + ", " + 
						peso + "kg, " + dieta + ", " + epoca);
		}
		
		statement.close();
		rs.close();		
	}
	
	//--A5) Todas os veículos que não estão ativos
	public static void consultaA5(Connection connection) throws SQLException {
		String sql = "SELECT veiculo.placa PLACA, veiculo.status STATUS " + 
				 "FROM tb_veiculos veiculo " + 
				 "WHERE veiculo.status IN ('M', 'I')";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta a5) Todas os veículos que não estão ativos:");
		System.out.println("PLACA, STATUS");
		while (rs.next()) {
			String placa = rs.getString("placa");
			String status = rs.getString("status");		
			System.out.println(" " + placa + ", " + status);
		}
		
		statement.close();
		rs.close();
	}
	
	
	//-----------------------------------------CONSULTAS B-----------------------------------------
	//--B1) Quantidade de dinossauros e de espécies por área
	public static void consultaB1(Connection connection) throws SQLException {
		String sql = "SELECT area.nomearea AREA, COUNT(dino.id_dino) QTD_DINOS, COUNT(DISTINCT dino.especie) QTD_ESPECIES " + 
				 "FROM tb_dinossauros dino INNER JOIN tb_areas area ON dino.id_area = area.id_area " + 
				 "GROUP BY area.nomearea";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta b1) Quantidade de dinossauros e de espécies por área:");
		System.out.println("AREA, QTD_DINOS, QTD_ESPECIES");
		while (rs.next()) {
			String area = rs.getString("area");
			int qtdDinos = rs.getInt("qtd_dinos");
			int qtdEspecies = rs.getInt("qtd_especies");			
			System.out.println(area + ", " + qtdDinos + ", " + qtdEspecies);
		}
		
		statement.close();
		rs.close();
	}
	
	//--B2) Quantidade de funcionarios por funcao
	public static void consultaB2(Connection connection) throws SQLException {
		String sql = "SELECT funcao.funcao FUNCAO, COUNT(func.id_funcionario) QTD_FUNCIONARIOS " + 
				 "FROM tb_funcoes funcao INNER JOIN tb_funcionarios func ON funcao.id_funcao = func.id_funcao " + 
				 "GROUP BY funcao.funcao " +
				 "ORDER BY FUNCAO";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta b2) Quantidade de funcionários por função:");
		System.out.println("FUNÇÃO, QTD_FUNCIONARIOS");
		while (rs.next()) {
			String funcao = rs.getString("funcao");
			int qtdFuncionarios = rs.getInt("qtd_funcionarios");			
			System.out.println(funcao + ", " + qtdFuncionarios);
		}
		
		statement.close();
		rs.close();
	}
		
	//--B3) Retorna os Eventos que possuem Tyrannosaurus a partir da data e hora atual
	public static void consultaB3(Connection connection) throws SQLException {
		String sql = "SELECT dino.nome, atracao.nome EVENTO, area.nomearea AREA, TO_CHAR(evento.datahoraevento, 'dd/mm/yyyy hh24:mi') HORA, evento.qtdpublico CAPACIDADE " +
				 "FROM tb_dinossauros dino " + 
				 "INNER JOIN tb_areas area ON dino.id_area = area.id_area " +
				 "INNER JOIN tb_areasatracoes evento ON area.id_area = evento.id_area " +
				 "INNER JOIN tb_atracoes atracao ON atracao.id_atracao = evento.id_atracao " +
				 "WHERE dino.nomeCientifico LIKE 'Tyrannosaurus%' AND evento.datahoraevento >= SYSDATE " +
				 "ORDER BY HORA";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta b3) Retorna os Eventos que possuem Tyrannosaurus a partir da data e hora atual:");
		System.out.println("NOME_DINO, EVENTO, AREA, HORA_DATA, CAPACIDADE");
		while (rs.next()) {			
			String nome = rs.getString("nome");		
			String evento = rs.getString("evento");
			String area = rs.getString("area");
			String hora = rs.getString("hora");
			int capacidade = rs.getInt("capacidade");
			System.out.println(nome + ", " + evento + ", " + area  + ", " + hora + ", " + capacidade);
		}
		
		statement.close();
		rs.close();
	}
	
	//--B4) Retorna os veículos que estão com algum funcionário
	public static void consultaB4(Connection connection) throws SQLException {
		String sql = "SELECT vec.placa PLACA, func.nome NOME, funcvec.retirada RETIRADA, funcvec.devolucao DEVOLUCAO " + 
				 "FROM tb_veiculos vec " + 
				 "INNER JOIN tb_funcionariosveiculos funcvec ON vec.placa = funcvec.placa " +
				 "INNER JOIN tb_funcionarios func ON funcvec.id_funcionario = func.id_funcionario " +
				 "WHERE funcvec.devolucao IS NULL " +
				 "ORDER BY RETIRADA";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta b4) Retorna os veículos que estão com algum funcionário:");
		System.out.println("PLACA, NOME, RETIRADA");
		while (rs.next()) {
			String placa = rs.getString("placa");
			String nome = rs.getString("nome");
			String retirada = rs.getString("retirada");
			System.out.println(placa + ", " + nome + ", " + retirada);
		}
			
		statement.close();
		rs.close();
	}
	
	//--B5) Retorna a quantidade de funcionários, a quantidade de dinossauros e a relação funcionário/dinossauro para cada área
	public static void consultaB5(Connection connection) throws SQLException {
		String sql = "SELECT area.nomearea AREA, COUNT(DISTINCT func.id_funcionario) QTD_FUNCIONARIOS, COUNT(DISTINCT dino.id_dino) QTD_DINOS, ROUND(COUNT(DISTINCT func.id_funcionario)/COUNT(DISTINCT dino.id_dino),2) RELACAO " +
				 "FROM tb_funcionarios func " + 
				 "INNER JOIN tb_areas area ON func.id_area = area.id_area " +
				 "INNER JOIN tb_dinossauros dino ON area.id_area = dino.id_area " +
				 "GROUP BY (area.nomearea)";
		Statement statement = connection.createStatement();
		ResultSet rs = statement.executeQuery(sql);
		
		System.out.println("\n\nConsulta b5) Retorna a quantidade de funcionários, a quantidade de dinossauros e a relação funcionário/dinossauro para cada área:");
		System.out.println("AREA, QTD_FUNCIONARIOS, QTD_DINOS, RELACAO");
		while (rs.next()) {			
			String area = rs.getString("area");		
			int qtdFuncionarios = rs.getInt("qtd_funcionarios");
			int qtdDinos = rs.getInt("qtd_dinos");
			double relacao = rs.getDouble("relacao");
			System.out.println(area + ", " + qtdFuncionarios + ", " + qtdDinos  + ", " + relacao);
		}
		
		statement.close();
		rs.close();
	}
		
		
	//-----------------------------------------CONSULTAS C-----------------------------------------
	//--C1) Retorna quantidade de veículos por ano
	
	
	
	//--C2) Retorna a media salarial dos funcionários por área
	
	
	
	//--C3) Status da capacidade de transporte da frota
	
	
	
	//--C4) Mostra as areas em que o menor salário é ao menos 6000
	
	
	
	//--C5) Mostra as áreas que tiverem eventos e somaram menos de 500 pessoas de público em eventos no último mês
	
	
	
	
	
	
	
	//-----------------------------------------CONSULTAS D-----------------------------------------
	//--D1) Nome e altura dos dinossauros que habitam areas maiores de 5000m2
	
	
	
	//--D2) Nome e sexo dos funcionários que trabalham em terreno arenoso
	
	
	
	//--D3) Mostra funcionarios que trabalham no Sul
	
	
	
	//--D4) Mostra funções que trabalham no coberto e as áreas 
	
	
	
	//--D5) Mostra todo funcionário e sua função que tem fator multiplicativo maior que 1.5 e salário base maior que 5000

	
	
}
	
