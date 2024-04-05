-- ------------------------------------------------- --
-- Cria o banco de dados da aplicação no MySQL.      --
-- Referências:                                      --
--  •  MySQL → https://www.w3schools.com/mysql       --
--  •  SQL ANSI → https://www.w3schools.com/sql      --
-- ------------------------------------------------- --
--      ATENÇÃO! DANGER! PERIGO! CUIDADO! OOOPS!     --
-- ------------------------------------------------- --
-- Este script só deve ser usado em desenvolvimento. --
-- Ele apaga o banco de dados e recria as estruturas --
-- do zero, apagando dados preexistentes.            --
-- Apague este arquivo no branch de produção.        --
-- ------------------------------------------------- --

-- Apaga o banco de dados caso ele exista.
DROP DATABASE IF EXISTS helloword;

-- Cria o banco de dados.
--     Seleciona o CHARSET UTF-8 para aramazenar caracteres do portugês.
--     Seleciona o COLLATE 'utf8mb4_general_ci' para fazer buscas case-insensitive.
CREATE DATABASE helloword CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Seleciona o banco de dados para criar as tabelas.
USE helloword;

-- Cria a tabela 'employee'.
CREATE TABLE employee (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    emp_photo VARCHAR(255),
    emp_name VARCHAR(127) NOT NULL,
    emp_birth DATE,
    emp_email VARCHAR(255) NOT NULL,
    emp_password VARCHAR(63) NOT NULL,
    emp_type ENUM('admin', 'author', 'moderator') DEFAULT 'moderator',
    emp_status ENUM('on', 'off', 'del') DEFAULT 'on'
);

-- Cria a tabela 'article'.
CREATE TABLE article (
    art_id INT PRIMARY KEY AUTO_INCREMENT,
    art_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    art_thumbnail VARCHAR(255),
    art_title VARCHAR(127),
    art_summary VARCHAR(255),
    art_author INT,
    art_content TEXT,
    art_views INT DEFAULT '0',
    art_status ENUM('on', 'off', 'del') DEFAULT 'on',
    FOREIGN KEY (art_author) REFERENCES employee(emp_id)
);

-- Cria a tabela 'comment'.
CREATE TABLE comment (
    cmt_id INT PRIMARY KEY AUTO_INCREMENT,
    cmt_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cmt_article INT,
    cmt_social_id VARCHAR(255),
    cmt_social_name VARCHAR(255),
    cmt_social_photo VARCHAR(255),
    cmt_social_email VARCHAR(255),
    cmt_content TEXT,
    cmt_status ENUM('on', 'off', 'del') DEFAULT 'on',
    FOREIGN KEY (cmt_article) REFERENCES article(art_id)
);

-- Cria a tabela 'contact'.
CREATE TABLE contact (
    ctt_id INT PRIMARY KEY AUTO_INCREMENT,
    ctt_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ctt_name VARCHAR(255),
    ctt_email VARCHAR(255),
    ctt_subject VARCHAR(255),
    ctt_message TEXT,
    ctt_status ENUM('received', 'read', 'answered', 'deleted') DEFAULT 'received'
);

-- --------------------------------------------------------------- --
-- Insere alguns dados "fake" nas tabelas para os testes iniciais. --
-- Dizemos "popular tabela com dados".
-- --------------------------------------------------------------- --

-- Popular tabela 'employee'.
INSERT INTO employee (
    emp_id, emp_photo, emp_name, emp_birth, emp_email, emp_password, emp_type
) VALUES 
('1', 'https://randomuser.me/api/portraits/lego/5.jpg', 'Joca da Silva', '2000-01-29', 'joca@silva.com', SHA1('senha123'), 'admin'),
('2', 'https://randomuser.me/api/portraits/women/33.jpg', 'Marineuza Siriliano', '1984-09-20', 'mari@neuza.com', SHA1('senha123'), 'author'),
('3', 'https://randomuser.me/api/portraits/men/40.jpg', 'Setembrino Trocatapas', '1999-10-21', 'set@brino.com', SHA1('senha123'), 'moderator'),
('4', 'https://randomuser.me/api/portraits/men/41.jpg', 'Hermenildo Sirigildo', '2001-12-24', 'herme@gildo.com', SHA1('senha123'), 'author');

-- Popular tabela 'article'.
INSERT INTO article
    (
        art_id, art_author, 
        art_thumbnail,
        art_title, 
        art_summary, 
        art_content
    )
VALUES
    (
        '1', '2', 
        'https://picsum.photos/200',
        'Java em Celulares Antigos',
        '"Java nos celulares antigos: o marco inicial dos aplicativos móveis.',
        '
        <p>Nos celulares antigos, Java desempenhou um papel crucial na introdução de aplicativos e jogos interativos. Com a capacidade de executar aplicativos leves e relativamente simples, a plataforma Java permitiu aos usuários dos primeiros dispositivos móveis acessar uma variedade de funcionalidades além das chamadas e mensagens de texto. Esses aplicativos Java frequentemente incluíam jogos, aplicativos de mensagens instantâneas, calculadoras e até mesmo aplicativos de navegação básica na web.</p>
        <p>O ambiente de execução Java, embora limitado em termos de desempenho e recursos em comparação com os dispositivos modernos, oferecia uma maneira eficaz de expandir a funcionalidade dos celulares antigos. Isso contribuiu significativamente para a popularização e adoção generalizada dos celulares na época, tornando-se uma plataforma fundamental para a introdução da era dos aplicativos móveis. O legado do Java nos celulares antigos ainda é sentido hoje, com muitos dos princípios e tecnologias subjacentes continuando a influenciar o desenvolvimento de aplicativos móveis e a evolução da computação móvel.<p/>
        <h3>1. Os Primeiros Passos: Dos Tijolões aos Celulares Analógicos</h3>
        <p>A história dos celulares remonta ao final do século XIX, mas sua popularidade só começou a crescer nas décadas de 1970 e 1980. Os primeiros telefones celulares eram grandes e pesados, mais comumente chamados de "tijolões". Eles operavam em redes analógicas e ofereciam apenas funcionalidades básicas de chamada. O lançamento do Motorola DynaTAC 8000X em 1983 marcou um ponto de virada. Embora ainda fosse volumoso, era o primeiro telefone celular verdadeiramente portátil. No entanto, seu preço exorbitante e a falta de infraestrutura de rede limitaram sua adoção em massa.</p>
        <h3>2. A Revolução Digital: A Era dos Celulares GSM</h3>
        <p>A década de 1990 testemunhou avanços significativos na tecnologia celular com a introdução das redes GSM (Global System for Mobile Communications). Os celulares agora eram menores, mais leves e capazes de enviar mensagens de texto além de fazer chamadas. Modelos icônicos como o Nokia 3310 se tornaram símbolos dessa era, com sua durabilidade lendária e jogos simples embutidos. Além disso, os celulares começaram a adotar recursos como agendas eletrônicas, calculadoras e despertadores, tornando-os dispositivos multifuncionais.</p>
        <h3>3. A Ascensão dos Smartphones: O Surgimento de uma Nova Era</h3>
        <p>O verdadeiro ponto de inflexão na evolução dos celulares ocorreu com o lançamento do iPhone pela Apple em 2007. Este dispositivo revolucionário combinava recursos de telefone celular com um reprodutor de música, uma câmera digital e acesso à Internet em um único dispositivo elegante e fácil de usar. O sucesso estrondoso do iPhone inspirou uma enxurrada de concorrentes a entrarem no mercado de smartphones. Logo, surgiram dispositivos Android, oferecendo uma alternativa robusta ao iOS da Apple. Com o tempo, os smartphones se tornaram indispensáveis ​​para muitos, permitindo não apenas comunicação instantânea, mas também acesso a uma infinidade de aplicativos e serviços, desde redes sociais até jogos, compras online e muito mais.</p>
        <h3>4. O Futuro dos Celulares: Rumo à Conectividade Ubíqua</h3>
        <p>À medida que avançamos para o futuro, os celulares estão caminhando em direção a uma era de conectividade ubíqua. Com o desenvolvimento contínuo da tecnologia 5G e além, os celulares estão se tornando ainda mais poderosos e capazes de suportar uma gama ainda maior de aplicativos e serviços. Além disso, espera-se que a Internet das Coisas (IoT) desempenhe um papel fundamental na interconexão de dispositivos, permitindo uma experiência cada vez mais integrada e automatizada em nossas vidas diárias. Os avanços em inteligência artificial e realidade aumentada também prometem transformar a maneira como interagimos com nossos celulares, tornando-os ainda mais intuitivos e adaptáveis às nossas necessidades individuais. No futuro, os celulares não serão apenas dispositivos de comunicação e entretenimento, mas sim ferramentas essenciais que moldam e facilitam nossa vida cotidiana em um mundo cada vez mais conectado.</p>
        <h3>Conclusão</h3>
        <p> A evolução dos celulares é uma história de inovação contínua e progresso tecnológico. Desde os dias dos tijolões analógicos até os smartphones ultramodernos de hoje, esses dispositivos têm sido uma força motriz por trás da transformação da sociedade moderna. À medida que continuamos nossa jornada rumo a um futuro cada vez mais conectado, é emocionante imaginar as possibilidades infinitas que os celulares ainda têm a oferecer.</p>

        '
    ), (
        '2', '4',
        'https://picsum.photos/201',
        'A Evolução dos Celulares: Uma Viagem pelos Avanços Tecnológicos que Moldaram o Mundo Moderno',
        'A evolução dos celulares moldou o mundo moderno.',
        '
        <p>Desde sua invenção até os dispositivos ultraconectados de hoje em dia, os celulares passaram por uma incrível evolução que transformou radicalmente a forma como nos comunicamos, trabalhamos e vivemos. Neste artigo, exploraremos essa jornada fascinante, desde os primeiros telefones celulares até os smartphones poderosos que carregamos em nossos bolsos hoje.</p>
        
        '
    ), (
        '3', '2',
        'https://picsum.photos/202',
        'Plantinhas na varanda',
        'Cuide bem das plantinhas da varanda neste verão.',
        '
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga ab, excepturi, ullam veniam perspiciatis officiis nostrum libero rerum ipsum minima tempore quisquam accusamus officia magni ea accusantium cumque reiciendis molestias.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate placeat obcaecati harum doloribus perferendis mollitia autem, sapiente fuga itaque officiis molestias libero ea, delectus vero error? Amet deserunt eum vero.</p>
            <figure>
            <img src="https://picsum.photos/300/200" alt="Imagem qualquer">    
            <figcaption>Imagem aleatória.</figcaption>                    
            </figure>
            <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Iusto nulla cum voluptate sed debitis minima consequuntur sint earum iste nam corporis aperiam dolorum temporibus itaque, corrupti velit architecto? Modi, quam!</p>
            <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ipsum quia distinctio iusto exercitationem qui accusantium ex ullam, excepturi illo quisquam beatae, nisi ad earum reprehenderit, maiores asperiores fuga nulla accusamus.</p>
        '
    );

INSERT INTO article
(
    art_id, art_author, 
    art_thumbnail,
    art_title, 
    art_summary, 
    art_content
)
VALUES
(
    '5', '3', 
    'https://picsum.photos/203',
    'Segredos do Jardim Zen',
    'Descubra os mistérios por trás da arte do jardim zen.',
    '
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga ab, excepturi, ullam veniam perspiciatis officiis nostrum libero rerum ipsum minima tempore quisquam accusamus officia magni ea accusantium cumque reiciendis molestias.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate placeat obcaecati harum doloribus perferendis mollitia autem, sapiente fuga itaque officiis molestias libero ea, delectus vero error? Amet deserunt eum vero.</p>
        <figure>
        <img src="https://picsum.photos/300/200" alt="Imagem qualquer">    
        <figcaption>Imagem aleatória.</figcaption>                    
        </figure>
        <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Iusto nulla cum voluptate sed debitis minima consequuntur sint earum iste nam corporis aperiam dolorum temporibus itaque, corrupti velit architecto? Modi, quam!</p>
        <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ipsum quia distinctio iusto exercitationem qui accusantium ex ullam, excepturi illo quisquam beatae, nisi ad earum reprehenderit, maiores asperiores fuga nulla accusamus.</p>
    '
), (
    '6', '4',
    'https://picsum.photos/204',
    'Cultivando Orquídeas em Casa',
    'Dicas e truques para manter suas orquídeas saudáveis e florescentes.',
    '
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga ab, excepturi, ullam veniam perspiciatis officiis nostrum libero rerum ipsum minima tempore quisquam accusamus officia magni ea accusantium cumque reiciendis molestias.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate placeat obcaecati harum doloribus perferendis mollitia autem, sapiente fuga itaque officiis molestias libero ea, delectus vero error? Amet deserunt eum vero.</p>
        <figure>
        <img src="https://picsum.photos/300/200" alt="Imagem qualquer">    
        <figcaption>Imagem aleatória.</figcaption>                    
        </figure>
        <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Iusto nulla cum voluptate sed debitis minima consequuntur sint earum iste nam corporis aperiam dolorum temporibus itaque, corrupti velit architecto? Modi, quam!</p>
        <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ipsum quia distinctio iusto exercitationem qui accusantium ex ullam, excepturi illo quisquam beatae, nisi ad earum reprehenderit, maiores asperiores fuga nulla accusamus.</p>
    '
), (
    '7', '1',
    'https://picsum.photos/205',
    'Criação de Cactos no Deserto',
    'Um guia para cultivar cactos em condições extremas de desertos.',
    '
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga ab, excepturi, ullam veniam perspiciatis officiis nostrum libero rerum ipsum minima tempore quisquam accusamus officia magni ea accusantium cumque reiciendis molestias.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate placeat obcaecati harum doloribus perferendis mollitia autem, sapiente fuga itaque officiis molestias libero ea, delectus vero error? Amet deserunt eum vero.</p>
        <figure>
        <img src="https://picsum.photos/300/200" alt="Imagem qualquer">    
        <figcaption>Imagem aleatória.</figcaption>                    
        </figure>
        <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Iusto nulla cum voluptate sed debitis minima consequuntur sint earum iste nam corporis aperiam dolorum temporibus itaque, corrupti velit architecto? Modi, quam!</p>
        <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ipsum quia distinctio iusto exercitationem qui accusantium ex ullam, excepturi illo quisquam beatae, nisi ad earum reprehenderit, maiores asperiores fuga nulla accusamus.</p>
    '
);

INSERT INTO article
    (
        art_id, art_author, 
        art_thumbnail,
        art_title, 
        art_summary, 
        art_content
    )
VALUES
    (
        '8', '3', 
        'https://picsum.photos/206',
        'O Segredo das Suculentas',
        'Descubra como cuidar das suculentas de forma fácil e eficaz.',
        '
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga ab, excepturi, ullam veniam perspiciatis officiis nostrum libero rerum ipsum minima tempore quisquam accusamus officia magni ea accusantium cumque reiciendis molestias.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate placeat obcaecati harum doloribus perferendis mollitia autem, sapiente fuga itaque officiis molestias libero ea, delectus vero error? Amet deserunt eum vero.</p>
            <figure>
            <img src="https://picsum.photos/300/200" alt="Imagem qualquer">    
            <figcaption>Imagem aleatória.</figcaption>                    
            </figure>
            <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Iusto nulla cum voluptate sed debitis minima consequuntur sint earum iste nam corporis aperiam dolorum temporibus itaque, corrupti velit architecto? Modi, quam!</p>
            <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ipsum quia distinctio iusto exercitationem qui accusantium ex ullam, excepturi illo quisquam beatae, nisi ad earum reprehenderit, maiores asperiores fuga nulla accusamus.</p>
        '
    ), (
        '9', '4',
        'https://picsum.photos/207',
        'Jardim Vertical em Pequenos Espaços',
        'Saiba como criar um jardim vertical mesmo em ambientes compactos.',
        '
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga ab, excepturi, ullam veniam perspiciatis officiis nostrum libero rerum ipsum minima tempore quisquam accusamus officia magni ea accusantium cumque reiciendis molestias.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate placeat obcaecati harum doloribus perferendis mollitia autem, sapiente fuga itaque officiis molestias libero ea, delectus vero error? Amet deserunt eum vero.</p>
            <figure>
            <img src="https://picsum.photos/300/200" alt="Imagem qualquer">    
            <figcaption>Imagem aleatória.</figcaption>                    
            </figure>
            <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Iusto nulla cum voluptate sed debitis minima consequuntur sint earum iste nam corporis aperiam dolorum temporibus itaque, corrupti velit architecto? Modi, quam!</p>
            <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ipsum quia distinctio iusto exercitationem qui accusantium ex ullam, excepturi illo quisquam beatae, nisi ad earum reprehenderit, maiores asperiores fuga nulla accusamus.</p>
        '
    ), (
        '10', '1',
        'https://picsum.photos/208',
        'Hortas Urbanas Sustentáveis',
        'Aprenda a cultivar uma horta urbana sustentável em sua própria casa.',
        '
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Fuga ab, excepturi, ullam veniam perspiciatis officiis nostrum libero rerum ipsum minima tempore quisquam accusamus officia magni ea accusantium cumque reiciendis molestias.</p>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptate placeat obcaecati harum doloribus perferendis mollitia autem, sapiente fuga itaque officiis molestias libero ea, delectus vero error? Amet deserunt eum vero.</p>
            <figure>
            <img src="https://picsum.photos/300/200" alt="Imagem qualquer">    
            <figcaption>Imagem aleatória.</figcaption>                    
            </figure>
            <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Iusto nulla cum voluptate sed debitis minima consequuntur sint earum iste nam corporis aperiam dolorum temporibus itaque, corrupti velit architecto? Modi, quam!</p>
            <p>Lorem ipsum, dolor sit amet consectetur adipisicing elit. Ipsum quia distinctio iusto exercitationem qui accusantium ex ullam, excepturi illo quisquam beatae, nisi ad earum reprehenderit, maiores asperiores fuga nulla accusamus.</p>
        '
    );

-- Popular tabela 'comment'.
INSERT INTO comment 
(
    cmt_article,
    cmt_social_id,
    cmt_social_name,
    cmt_social_photo,
    cmt_social_email,
    cmt_content
) VALUES
(
    '1', 
    'abc123',
    'Mariah do Bairro', 
    'https://randomuser.me/api/portraits/women/40.jpg',
    'mariahbairro@gmail.com',
    'Não gosto de Figos. Eles tem caroços.'
), (
    '2', 
    'def456',
    'Esmeraldino', 
    'https://randomuser.me/api/portraits/lego/7.jpg',
    'esmeraldo@dino.com',
    'Prefiro os cravos às rosas. Pelo menos eles não tem espinhos.'
), (
    '1', 
    'ghi890',
    'Pedro Pedroso', 
    'https://randomuser.me/api/portraits/men/87.jpg',
    'pedro@pedroso.com',
    'Fogos são gostosos somente no Natal.'
);

-- Popular tabela 'contact'.