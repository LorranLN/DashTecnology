<?php

// Carrega configurações globais
require("_global.php");

// Configurações desta página
$page = array(
    "title" => $site['slogan'], // Título desta página
    "css" => "index.css", // Folha de estilos desta página
);

/**
 * Listar os artigos do banco de dados
 * Regras / parâmetros:
 *  • Ordenados pela data de publicação com os mais recentes primeiro
 *  • Obter somente artigos no passado e presente
 *      • Não obter artigos agendados para o futuro
 *  • Obter somente artigos com status = 'on'
 *  • Obter os campos id, thumbnail, title, summary
 **/
$sql = <<<SQL

SELECT
-- Obter o id
	art_id
FROM article

-- Obter somente artigos no passado e presente
-- Não obter artigos agendados para o futuro
	WHERE art_date <= NOW()	  	
        
-- Obter somente artigos com status = 'on'
		AND art_status = 'on'        	

-- Ordenados pela data de publicação com os mais recentes primeiro
	ORDER BY art_date DESC;

SQL;

//  Executa o SQL e armazena os resultados em $res
$res = $conn->query($sql);

// Conta os registros e armazena em $total
$total = $res->num_rows;

// Variável que contém a lista de artigos em HTML e título
$articles = '';

// Se não tem artigos, exibe um aviso
if ($total == 0) :
    $articles = "<h2>Artigos recentes</h2><p>Não achei nada!</p>";
else :

    // Título
    if ($total == 1) $articles = '<h2>Artigo mais recente</h2>';
    else $articles = "<h2>{$total} artigos mais recentes</h2>";

    // Loop para obter cada artigo
    while ($art = $res->fetch_assoc())

        // Chama a função que gera a lista de artigos
        $articles .= view_article($art['art_id']);

endif;

// Inclui o cabeçalho do documento
require('_header.php');
?>

<article>
     <!-- Conteúdo inútil só para testes visuais -->
     <h2>A Evolução dos Celulares: Uma Viagem pelos Avanços Tecnológicos que Moldaram o Mundo Moderno</h2>
                    <p>Desde sua invenção até os dispositivos ultraconectados de hoje em dia, os celulares passaram por uma incrível evolução que transformou radicalmente a forma como nos comunicamos, trabalhamos e vivemos. Neste artigo, exploraremos essa jornada fascinante, desde os primeiros telefones celulares até os smartphones poderosos que carregamos em nossos bolsos hoje.</p>
                    <h3>1. Os Primeiros Passos: Dos Tijolões aos Celulares Analógicos</h3>
                    <p>

                        A história dos celulares remonta ao final do século XIX, mas sua popularidade só começou a crescer nas décadas de 1970 e 1980. Os primeiros telefones celulares eram grandes e pesados, mais comumente chamados de "tijolões". Eles operavam em redes analógicas e ofereciam apenas funcionalidades básicas de chamada.
                        
                        O lançamento do Motorola DynaTAC 8000X em 1983 marcou um ponto de virada. Embora ainda fosse volumoso, era o primeiro telefone celular verdadeiramente portátil. No entanto, seu preço exorbitante e a falta de infraestrutura de rede limitaram sua adoção em massa.</p>
                        <h3>2. A Revolução Digital: A Era dos Celulares GSM</h3>
                        <p>

                        A década de 1990 testemunhou avanços significativos na tecnologia celular com a introdução das redes GSM (Global System for Mobile Communications). Os celulares agora eram menores, mais leves e capazes de enviar mensagens de texto além de fazer chamadas. Modelos icônicos como o Nokia 3310 se tornaram símbolos dessa era, com sua durabilidade lendária e jogos simples embutidos.
                        
                        Além disso, os celulares começaram a adotar recursos como agendas eletrônicas, calculadoras e despertadores, tornando-os dispositivos multifuncionais.</p>
                        <h3>3. A Ascensão dos Smartphones: O Surgimento de uma Nova Era
                        </h3>
                        <p>

                        O verdadeiro ponto de inflexão na evolução dos celulares ocorreu com o lançamento do iPhone pela Apple em 2007. Este dispositivo revolucionário combinava recursos de telefone celular com um reprodutor de música, uma câmera digital e acesso à Internet em um único dispositivo elegante e fácil de usar.
                        
                        O sucesso estrondoso do iPhone inspirou uma enxurrada de concorrentes a entrarem no mercado de smartphones. Logo, surgiram dispositivos Android, oferecendo uma alternativa robusta ao iOS da Apple. Com o tempo, os smartphones se tornaram indispensáveis ​​para muitos, permitindo não apenas comunicação instantânea, mas também acesso a uma infinidade de aplicativos e serviços, desde redes sociais até jogos, compras online e muito mais.</p>    
                        <h3>4. O Futuro dos Celulares: Rumo à Conectividade Ubíqua
                        </h3>
                        <p

                        Atualmente, estamos testemunhando avanços significativos na evolução dos celulares. A introdução de tecnologias como 5G promete velocidades de conexão ainda mais rápidas e maior largura de banda, possibilitando experiências mais imersivas, como realidade aumentada e transmissões de vídeo de alta definição em tempo real.
                        
                        Além disso, espera-se que os avanços em inteligência artificial, realidade aumentada e Internet das Coisas (IoT) continuem a moldar o futuro dos celulares. Essas tecnologias permitirão uma integração mais profunda entre nossos dispositivos e o ambiente ao nosso redor, transformando não apenas a maneira como nos comunicamos, mas também como interagimos com o mundo.</p>    
                        <h3>Conclusão
                        </h3>
                        <p>

                        A evolução dos celulares é uma história de inovação contínua e progresso tecnológico. Desde os dias dos tijolões analógicos até os smartphones ultramodernos de hoje, esses dispositivos têm sido uma força motriz por trás da transformação da sociedade moderna. À medida que continuamos nossa jornada rumo a um futuro cada vez mais conectado, é emocionante imaginar as possibilidades infinitas que os celulares ainda têm a oferecer.</p>   
</article>

<aside>
<?php echo $articles ?>

    <?php
    // Mostra os artigos mais visualizados
    require('widgets/_mostviewed.php');

    
    ?>
</aside>

<?php require('_footer.php'); ?>