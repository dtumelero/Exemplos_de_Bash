menu(){
    read op
    case "$op" in
    	1)
    		echo "op 1"
            gremio
    	;;

    	2)
            echo "op 2"
            inter
    	;;

        3)
            echo "sair"
            read pause
            break
        ;;
    
    	*)
    		echo "Op��o inv�lida:" $op
    		op_inv
    	;;
    esac
}

gremio(){
    echo "Gr�mio"
    read pause
    menu
}

inter(){
    echo "Inter"
    read pause
    menu
}

op_inv(){
    echo "Op��o inv�lida, retornando ao menu principal"
    read pause
    menu
}
