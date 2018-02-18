<!DOCTYPE html>
<html lang="ja">
    <head>
        <meta charset="utf-8">
        <title>購入情報</title>
        <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">

        <style>
        body{
            background-color:#ffd49a;
        }
        header{
            background-color:#ff7789;
        }
        .title{
            display:inline-block;
            color:#ffd8d8;

        }
        .message{
            background-color:#fcd4d4;
            padding:15px;
            text-align:center;
        }
        .red{
            font-weight:bold;
            color:red;
        }
        img{
            width:150px;
        }
        ul,li{
            list-style:none;
        }
        .goods{
            background-color:#ffffde;
        }
        .goods_box{
            border-bottom:1px dotted #96ca34;
            padding:15px;
        }
            
        </style>
    </head>
    <body>
        <header>
            <a href="shop_goods.php"><h1 class="title">CodeCampSHOP</h1></a>
            <span style="color:white;">
                ユーザー名：<?php echo htmlspecialchars($user_name,ENT_QUOTES,'utf-8');?>
            </span>
            <a href="shopping_cart.php"><span class="fa fa-shopping-cart fa-4x" style="color:white;"></span></a>
            <a href="log_out.php" style="text-decoration:none; font-weight:bold; color:white;">ログアウト</a>
        </header>
        <div class="attention">
<?php
if(count($err_msg)>0){ ?>

<?php
foreach ($err_msg as $value){?>
            <p><?php echo htmlspecialchars($value,ENT_QUOTES,'utf-8');?></p>
<?php } ?>
<?php } ?>
        </div>
        <div class="message">
            <p>ご購入ありがとうございました</p>
        </div>
        <div class="goods">
            <ul>
<?php
foreach($get_cart_table as $value){ ?>
                <li>
                    <div class="goods_box">
                        <span>
                            <img src="img/<?php echo $value['img'];?>">
                        </span>
                        <span>
                            <?php echo htmlspecialchars($value['name'],ENT_QUOTES,'utf-8');?>
                        </span>
                        <span>
                            値段：<?php echo htmlspecialchars($value['price'],ENT_QUOTES,'utf-8');?>円
                        </span>
                        <span>
                            数量：<?php echo htmlspecialchars($value['amount'],ENT_QUOTES,'utf-8');?>
                        </span>
                    </div>
                </li>
<?php } ?>
            </ul>
            
        </div>
        <div calss="result">
            <span>合計：</span>
            <span class="red"><?php echo htmlspecialchars($sum_answer,ENT_QUOTES,'utf-8');?>円</span>
        </div>
    </body>
</html>