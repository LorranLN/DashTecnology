<?php
// Carrega configurações globais
require("_global.php");

// Configurações desta página
$page = array(
    "title" => "Lendo e Entendendo", // Título desta página
    "css" => "index.css",            // Folha de estilos desta página
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
    // Prepara e executa a query SQL para inserir o novo artigo no banco de dados
    $sql = "
    INSERT INTO article (
        art_title, art_content, art_date, art_summary, art_thumbnail, art_author
    ) VALUES (
        '$titulo', '$conteudo', '$data_publicacao', '$resumo', '$imagem', '1'
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

    <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
    <label for="titulo">Título:</label><br>
    <input type="text" id="titulo" name="titulo"><br><br>

    <label for="resumo">Resumo:</label><br>
    <textarea id="resumo" name="resumo" rows="3" cols="50"></textarea><br><br>

    <label for="conteudo">Conteúdo:</label><br>
    <textarea id="conteudo" name="conteudo" rows="5" cols="50"></textarea><br><br>

    <label for="imagem">Link da Imagem:</label><br>
    <input type="text" id="imagem" name="imagem"><br><br>

    <label for="data_publicacao">Data de Publicação:</label><br>
    <input type="datetime-local" id="data_publicacao" name="data_publicacao"><br><br>

    <input type="submit" value="Publicar">
</form>

</form>

</article>

<aside></aside>

<?php
// Inclui o rodapé do documento
require('_footer.php');
?>
