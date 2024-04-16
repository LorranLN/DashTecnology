<?php
// Carrega configurações globais
require("_global.php");

if (!isset($_COOKIE['user']))
    header('Location:login.php');
else {
    $user=unserialize($_COOKIE['user']);
   // debug($user,true);
}

// Configurações desta página
$page = array(
    "title" => "Lendo e Entendendo", // Título desta página
    "css" => "new_article.css",            // Folha de estilos desta página
    "js" => "index.js",              // JavaScript desta página
);

// Inclui o cabeçalho do documento
require('_header.php');

$feedback = '';
// Verifica se o formulário foi enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Obtém os dados do formulário
    $titulo = $_POST["titulo"];
    $resumo = $_POST["resumo"];
    $conteudo = $_POST["conteudo"];
    $imagem = $_POST["imagem"];
    $data_publicacao = $_POST["data_publicacao"];
    $userid=$_POST['userid'];
    // Prepara e executa a query SQL para inserir o novo artigo no banco de dados
    $sql = "
    INSERT INTO article (
        art_title, art_content, art_date, art_summary, art_thumbnail, art_author
    ) VALUES (
        '$titulo', '$conteudo', '$data_publicacao', '$resumo', '$imagem', '$userid'
    )
    ";

    if ($conn->query($sql) === TRUE) {
        $feedback = "Novo artigo criado com sucesso!";
    } else {
        $feedback = "Erro ao criar o artigo: " . $conn->error;
    }
}
?>

<article>
    <h2>Novo Artigo</h2>

    <p><?php echo $feedback ?></p>

    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" enctype="multipart/form-data">
        <input type="hidden" name="userid" value="<?php echo $user['emp_id']?>">
        <label for="titulo">Título:</label><br>
        <input type="text" id="titulo" name="titulo"><br><br>

        <label for="resumo">Resumo:</label><br>
        <textarea id="resumo" name="resumo" rows="3" cols="50"></textarea><br><br>

        <label for="conteudo">Conteúdo:</label><br>
        <textarea id="conteudo" name="conteudo" rows="5" cols="50"></textarea><br><br>

        <!-- Botão original para adicionar imagem via link -->
        <label for="imagem">Link para Imagem Thumbnail:</label><br>
        <input type="text" id="imagem" name="imagem"><br><br>

        <!-- Botão para adicionar imagem no texto -->
        <button type="button" id="btnAddImage">Adicionar endereço de imagem ao artigo</button><br><br>

        <label for="data_publicacao">Data de Publicação:</label><br>
        <input type="datetime-local" id="data_publicacao" name="data_publicacao"><br><br>

        <input type="submit" value="Publicar">
    </form>

</article>

<aside>
    <button type="button" onclick="location.href='logout.php'">Fazer logout</button>
</aside>

<script>
    var lastClickPos = 0;

    // Função para inserir tag de imagem no campo de conteúdo onde clicado
    document.getElementById("conteudo").addEventListener("click", function(event) {
        // Verifica se o alvo do clique foi o campo de conteúdo
        if (event.target === document.getElementById("conteudo")) {
            // Obtém a posição do cursor
            lastClickPos = document.getElementById("conteudo").selectionStart;
        }
    });

    // Função para inserir tag de imagem no último local onde o mouse clicou
    document.getElementById("btnAddImage").addEventListener("click", function() {
        // Insere uma tag de imagem no campo de conteúdo na posição do último clique
        var contentField = document.getElementById("conteudo");
        var imageTag = '<img src="URL_DA_IMAGEM" alt="Descrição da Imagem">';
        contentField.value = contentField.value.slice(0, lastClickPos) + imageTag + contentField.value.slice(lastClickPos);
    });

    // Função para adicionar imagem do dispositivo
    document.getElementById("btnAddImageDevice").addEventListener("click", function() {
        document.getElementById("inputImage").click();
    });
</script>

<?php
// Inclui o rodapé do documento
require('_footer.php');
?>

