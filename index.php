<!DOCTYPE html>
<html>
<head>
<title>Flashy</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="static/reset.css">
<link rel="stylesheet" href="static/style.css">
</head>
<body>
<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

class Auth {
    private $user = 'username';
    private $pass = 'password';

    public function __construct() {
        if (!isset($_SERVER['PHP_AUTH_USER']) ||
            $_SERVER['PHP_AUTH_USER'] != $this->user ||
            !isset($_SERVER['PHP_AUTH_PW']) ||
            $_SERVER['PHP_AUTH_PW']   != $this->pass
            ) {
            header('HTTP/1.0 401 Unauthorized');
            header('WWW-Authenticate: Basic realm="Flashy"');
            echo 'You are not authorized to access this site. Please log in.';
            exit;
        }
    }
}

class Card {
    public $id, $boxID, $classID, $front, $back;
    public function __construct($id, $boxID, $classID, $front, $back) {
        $this->id=$id;
        $this->boxID=$boxID;
        $this->classID=$classID;
        $this->front=$front;
        $this->back=$back;
    }

    public static function createFromDBRow($row) {
        return new Card($row['id'], $row['box_id'], $row['class_id'], $row['front'], $row['back']);
    }
}

class DB {
    private $db;

    public function __construct() {
        $this->db = new PDO('sqlite:db.db');
        $this->db->query("PRAGMA foreign_keys = ON");
    }

    public function __destruct() {
        $db = null;
    }

    public function getClasses() {
        return $this->db->query("SELECT * FROM classes");
    }

    public function getBoxes() {
        return $this->db->query("SELECT * FROM boxes");
    }

    public function getBoxNameByID($boxID) {
        return $this->db->query("SELECT name FROM boxes WHERE id='".$boxID."' LIMIT 1")->fetchColumn();
    }

    public function getClassNameByID($classID) {
        return $this->db->query("SELECT name FROM classes WHERE id='".$classID."' LIMIT 1")->fetchColumn();
    }

    public function getNumBoxes() {
        return $this->db->query("SELECT COUNT(*) FROM boxes")->fetchColumn();
    }

    public function getFirstCardByBoxID($boxID) {
        $res = $this->db->query("SELECT * FROM cards WHERE box_id = '" . $boxID . "' LIMIT 1")->fetchAll();
        if (count($res) > 0) {
            $row = $res[0];
            return Card::createFromDBRow($row);
        }
        else {
            return null;
        }
    }

    public function getCardByID($card_id) {
        $res = $this->db->query("SELECT * FROM cards WHERE id = '" . $card_id . "' LIMIT 1")->fetchAll();
        if (count($res) > 0) {
            $row = $res[0];
            return Card::createFromDBRow($row);
        }
        else {
            return null;
        }
    }

    public function getNumCardsByBoxID($boxID) {
        return $this->db->query("SELECT COUNT(*) FROM cards where box_id='" . $boxID . "'")->fetchColumn();
    }

    public function getNumCards() {
        return $this->db->query("SELECT COUNT(*) FROM cards")->fetchColumn();
    }

    public function updateCard($card) {
        $origCard = $this->getCardByID($card->id);
        if($origCard->boxID != $card->boxID) {
            $res = $this->db->query("UPDATE cards SET box_id='".$card->boxID."' WHERE id='".$card->id."'");
        }
        if($origCard->classID != $card->classID) {
            $res = $this->db->query("UPDATE cards SET class_id='".$card->classID."' WHERE id='".$card->id."'");
        }
        if($origCard->front != $card->front) {
            $res = $this->db->query("UPDATE cards SET front='".$card->front."' WHERE id='".$card->id."'");
        }
        if($origCard->back != $card->back) {
            $res = $this->db->query("UPDATE cards SET back='".$card->back."' WHERE id='".$card->id."'");
        }
    }

    public function createCard($card) {
        if($card->classID != null && $card->front != null && $card->back != null) {
            $res = $this->db->query("INSERT INTO cards (box_id,class_id,front,back) VALUES(3,".$card->classID.",'".$card->front."','".$card->back."')");
        }
    }

    public function deleteCard($cardID) {
        if($cardID != null) {
            $res = $this->db->query("DELETE FROM cards WHERE id='".$cardID."'");
        }
    }

    public function getRandomCardByBoxID($boxID) {}
    public function getAllCardsByBoxID($boxID) {}
}

class App {
    private $db,
    $selectedCard,
    $selectedBoxID,
    $testInput,
    $message,
    $checkCase = true;

    public function __construct() {
        $this->db = new DB();

        $this->handleInput();

        // Select random card from selected box since none is selected yet:
        if($this->selectedBoxID != null && $this->selectedCard == null) {
            $this->selectNewCard();
            /*
            if($this->selectedCard != null) {
                // Give the user some info...
                $this->message = $this->selectedCard->front.' | '.$this->db->getClassNameByID($this->selectedCard->classID);
            }
            */
        }

        // Do some evaluation...
        if(isset($this->selectedCard) && $this->testInput != null) {
            // Case sensitive...
            if($this->checkCase) {
                $a = $this->selectedCard->back;
                $b = $this->testInput;
            }
            // Case insensitive...
            else {
                $a = strtolower($this->selectedCard->back);
                $b = strtolower($this->testInput);
            }
            //Answer correct:
            if($a == $b) {
                if($this->selectedCard->back == $this->testInput) {
                    $this->message = 'Correct';
                }
                else {
                    $this->message = 'Almost Correct';
                }
                
                if($this->selectedCard->boxID >= 0 && $this->selectedCard->boxID < 3) {
                    $this->selectedCard->boxID = 4;
                }
                else if($this->selectedCard->boxID >= 3 && $this->selectedCard->boxID < $this->db->getNumBoxes()-1) {
                    $this->selectedCard->boxID += 1;
                }
            }
            //Answer wrong:
            else {
                $this->message = 'Wrong - Correct answer:<br>'.$this->selectedCard->back;
                if($this->selectedCard->boxID > 0 && $this->selectedCard->boxID <= 3) {
                    $this->selectedCard->boxID -= 1;
                }
                else if($this->selectedCard->boxID > 3 && $this->selectedCard->boxID < $this->db->getNumBoxes()) {
                    $this->selectedCard->boxID = 2;
                }
            }
            $this->db->updateCard($this->selectedCard);
            $this->testInput = '';
            $this->selectNewCard();
        }
    
        $this->renderTest();
        $this->renderBoxes();
        $this->renderConfigurator();
    }

    private function renderTest() {
        echo '<div class="test_view">' . "\n";
        echo '<div class="std_row">' . $this->message . "</div>\n";
        echo '<div class="std_row">'.($this->selectedCard == null ? '' : $this->selectedCard->front.' | '.$this->db->getClassNameByID($this->selectedCard->classID))."</div>\n";
        echo '<form method="POST">' . "\n";
        echo '<input type="text" name="test_input"'
        .($this->testInput == null ? '' : ' value="' . $this->testInput . '"')
        .($this->selectedCard == null ? '' : ' autofocus')
        .'>'."\n";
        echo '<input class="btn_row" type="submit" value="Check">' . "\n";
        echo '<input type="hidden" name="card_id" value="'.($this->selectedCard == null ? '' : $this->selectedCard->id).'">'."\n";
        echo '</form>' . "\n";
        echo '<a class="btn_row'.($this->checkCase ? ' selected' : '').'" href="'.$this->createExtendedGetParameterString('check_case', (int)!$this->checkCase).'">Case sensitive</a>' . "\n";
        echo "</div>\n";
    }

    private function renderBoxes() {
        echo '<div class="box_view">'."\n";
        echo "<ul>\n";
        foreach ($this->db->getBoxes() as $box) {
            $this->addGetParameter('box_id', $box['id']);
            $this->addGetParameter('check_case', $this->checkCase);
            if (isset($this->selectedBoxID)) {
                $html_selected = $box['id'] == $this->selectedBoxID ? ' class="selected"' : '';
            }
            else {
                $html_selected = '';
            }
            
            echo "<li>\n";
            echo '<a href="'.$this->createGetParameterString().'"'.$html_selected.'>'.$box['name'].' ('.$this->db->getNumCardsByBoxID($box['id']).")</a>\n";
            echo "</li>\n";
        }
        echo "</ul>\n";
        echo "</div>\n";
    }

    private function renderConfigurator() {
        echo '<div class="configurator_view">' . "\n";
        echo '<form method="POST">' . "\n";
        echo '<div><input type="text" name="card_front" value="'.($this->selectedCard != null ? $this->selectedCard->front : 'Front').'"></div>' . "\n";
        echo '<div><input type="text" name="card_back" value="'. ($this->selectedCard != null ? $this->selectedCard->back  : 'Back') .'"></div>' . "\n";
        echo '<select name="class_id">'."\n";
        foreach ($this->db->getClasses() as $class) {
            if($this->selectedCard != null) {
                $setSelected = $class['id'] == $this->selectedCard->classID ? ' selected="selected"' : '';
            }
            else {
                $setSelected = '';
            }
            echo '<option value="'.$class['id'].'"'.$setSelected.'>'.$class['name']."</option>\n";
        }
        echo "</select>\n";
        echo '<div><input class="btn_row" type="submit" name="action_create" value="Create"></div>' . "\n";
        echo '<div><input class="btn_row" type="submit" name="action_replace" value="Replace"></div>' . "\n";
        echo '<div><input class="btn_row" type="submit" name="action_delete" value="Delete"></div>' . "\n";
        echo '<input type="hidden" name="card_id" value="'.($this->selectedCard == null ? '' : $this->selectedCard->id).'">'."\n";
        echo '</form>' . "\n";
        echo "</div>\n";
    }

    private function handleInput() {
        if (isset($_REQUEST['box_id']) &&
            $_REQUEST['box_id'] >= 0 &&
            $_REQUEST['box_id'] < $this->db->getNumBoxes())
            {
            $this->selectedBoxID = $_REQUEST['box_id'];
        }
        if (isset($_REQUEST['card_id']) &&
            $_REQUEST['card_id'] >= 0)
            {
            $this->selectedCard = $this->db->getCardByID($_REQUEST['card_id']);
        }
        if (isset($_REQUEST['check_case']) &&
            $_REQUEST['check_case'] == 1)
            {
            $this->checkCase = true;
        }
        else $this->checkCase = false;

        if (isset($_REQUEST['test_input']) && $_REQUEST['test_input'] != '') {
            $this->testInput = trim($_REQUEST['test_input']);
        }

        // Create a new Card in the database
        if (isset($_REQUEST['action_create']) &&
            isset($_REQUEST['class_id']) && $_REQUEST['class_id'] != null &&
            isset($_REQUEST['card_front']) && $_REQUEST['card_front'] != null &&
            isset($_REQUEST['card_back']) && $_REQUEST['card_back'] != null)
            {
                $card = new Card(null, 3, $_REQUEST['class_id'], trim($_REQUEST['card_front']), trim($_REQUEST['card_back']));
                $this->db->createCard($card);
        }
        // Modify an existing card in the database
        else if (isset($_REQUEST['action_replace']) &&
            isset($_REQUEST['class_id']) && $_REQUEST['class_id'] != null &&
            isset($_REQUEST['card_front']) && $_REQUEST['card_front'] != null &&
            isset($_REQUEST['card_back']) && $_REQUEST['card_back'] != null &&
            $this->selectedCard != null)
            {
                $card = new Card($this->selectedCard->id, $this->selectedCard->boxID, $_REQUEST['class_id'], trim($_REQUEST['card_front']), trim($_REQUEST['card_back']));
                $this->db->updateCard($card);
                // Reload the updated card
                $this->selectedCard = $this->db->getCardByID($card->id);
        }
        // Delete a card from the database
        else if (isset($_REQUEST['action_delete']) &&
            $this->selectedCard != null)
            {
            $this->db->deleteCard($this->selectedCard->id);
            // Make sure the deleted card is no longer selected
            $this->selectedCard = null;
        }
    }

    private function selectNewCard() {
        $this->selectedCard = $this->db->getFirstCardByBoxID($this->selectedBoxID);
    }

    private function addGetParameter($parameterName, $parameterValue) {
        $_GET[$parameterName] = $parameterValue;
    }

    private function createGetParameterString() {
        $tmp = '?';
        foreach($_GET as $key => $value) {
            $tmp = $tmp . $key . '=' . $value . '&';
        }
        return trim($tmp, '&');//substr($tmp, 0, -1);
    }

    //Add a temporary extra key/value pair to string
    private function createExtendedGetParameterString($key, $value) {
        $this->deleteGetParameter($key);
        $existingParams = $this->createGetParameterString();
        return $existingParams == '?' ? '?'.$key.'='.$value : $existingParams.'&'.$key.'='.$value;
    }

    private function deleteGetParameter($key) {
        unset($_GET[$key]);
    }        
}

new Auth();
new App();
?>
</body>
</html>
