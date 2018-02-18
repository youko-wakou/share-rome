<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8">
        <title> ログインページ</title>
        <style>
            .message{
                background-color:pink;
            }
        </style>
    </head>
    <body>
        <div id="wrap">
            <header>
                <h1>CodeCampSHOP</h1>
            </header>
            <div id="form-range">
                <form method="post">
                    <div class="form-box">
                        <lagel for="user">ユーザー名：</lagel>
                        <input type="text" name="user" id="user" placeholder="ユーザー名">
                    </div>
                    <div class="post">
                        <label for = "pass">パスワード：</label>
                        <input type="text" name="pass" id="pass" placeholder="パスワード">
                    </div>
                    <div class="form-box">
                        <input type="submit" value="ユーザーを新規作成する">
                    </div>
                    
                </form>
                
                <div class="message">
    <?php 
    if(count($err_msg)>0){ ?>
    <?php
    foreach($err_msg as $value){ ?>
                <p><?php echo htmlspecialchars($value,ENT_QUOTES,'utf-8');?></p>
    <?php } ?>
    <?php } ?>
    
    <?php 
    if(count($info_data)>0){ ?>
    <?php
    foreach($info_data as $value){ ?>
                <p><?php echo htmlspecialchars($value,ENT_QUOTES,'utf-8');?></p>
    <?php } ?>
    <?php } ?>
                </div>
    <?php 
    if(count($info_data) !==0){?>
                <a href="login.php">ログインページへ戻る</a>
    <?php } ?>
            </div>
      </div>
        
    </body>
</html>