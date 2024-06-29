# Entrega Franco Faustino - 328298

#funcion para solicitar usuario, contrasena y verificar que sean correctas.
solicitar_y_autenticar(){
	ok=true #Esta variable es para luego darle permiso a acceder al menú o no.
}


#funcion para mostrar al usuario con que numero acceden a cada opcion.
opciones_menú(){
	echo ""
	echo "Menú Principal"
	echo ""
	echo "1) Configurar letra de inicio"
	echo "2) Configurar letra fin"
	echo "3) Configurar letra contenida"
	echo "4) Ingresar vocal"
        echo "5) Algoritmo 1"
        echo "6) Algoritmo 2"
        echo "7) Salir"
}



salir(){ #Para salir del menu.
	echo ""
	echo "Saliendo del sistema ... "
	echo ""
	echo "El sistema se ha cerrado."
	echo ""
	itera=false #Cambia el valor, por lo tanto while deja de iterar.
}


#funcion para configurar letra de início: 
config_letra_i(){
	read -p "Ingresa la letra que se guardara como la letra inicial: " letra_inicio
	echo "La letra $letra_inicio se establecio correctamente."
}



#funcion para configurar letra final:
config_letra_f(){
	read -p "Ingrese la letra que se guardara como la letra final: " letra_final
	echo "La letra $letra_final se establecio correctamente."
}



#funcion para configurar la letra contenida.
config_letra_c(){
	read -p "Ingrese la letra que se guardara como la letra contenida: " letra_contenida
        echo "La letra $letra_contenida se establecio correctamente."
}



#funcion para configurar la vocal establecida.
ing_vocal(){
	read -p "Ingrese la letra que se guardara como la vocal: " letra_vocal
        echo "La letra $letra_vocal se establecio correctamente."
}



algoritmo1(){
	#Para obtener el promedio de los numeros
	suma=0
	read -p "Ingrese la cantidad de dato: " cantidad_datos
	declare -a datos  #Creamos una variable como array.
	for (( i = 1; i<= cantidad_datos; i++)); do #Para leer la cantidad de datos que nos pide y llenar el array con los datos.
        	read -p "Ingrese el dato $i: " dato
        	datos+=("$dato")
	done

	for dato in "${datos[@]}"; do #Para ir sumando cada dato que hay en Datos; que luego nos ayudara a realizar el promedio.
        	suma=$((suma + dato))
	done
	promedio=$((suma / cantidad_datos)) #Para conseguir el promedio
	echo ""
	echo "El promedio de los datos que han sido ingresados es: $promedio"
	echo ""

	#Para encontrar el menor:
	menor=${datos[0]} #Tomamo como partida el primer dato del array y vamos comparando para encontrar un valor menor.
	for dato in "${datos[@]}"; do #Recorremos el array en busca de datos menores.
        	if ((dato < menor)); then #Si no los hay, nos quedamos con el primero.
                	menor=$dato
        	fi
	done
	echo ""
	echo "El menor de los datos es: $menor"
	echo ""

	#Para encontrar el mayor.
	mayor=${datos[0]} #Utilizamos la misma logica que el menor.
	for dato in "${datos[@]}"; do 
        	if ((dato > mayor)); then
                	mayor=$dato
        	fi
	done
	echo ""
	echo "El mayor de los datos es: $mayor"
	echo ""
}



algoritmo2(){
	echo ""
	read -p "Ingrese una palabra y corroboraremos si es capicúa: " palabra
	echo ""
	palabra_invertida=$(echo "$palabra" | rev) #Utilizamos rev; tiene la funcion de invertir  la cadena de caracteres.
	if [ "$palabra" == "$palabra_invertida" ]; then #Si la palabra queda igual cuando se invierte, entonces es capicua.
		echo "Correcto, la palabra $palabra se considera capicúa"
	else
		echo "Incorrecto, la palabra ingresada no es capicúa, invertida queda: $palabra_invertida"
	fi
	echo ""
}



seleccionar_opcion(){
itera=true
while [ "$itera" == "true" ]; do #Para que se pueda elegir opciones hasta que el usuario seleccione salir.
	echo ""
	read -p "Seleccione una opcion: " opcion
	case $opcion in
		1) config_letra_i ;;
		2) config_letra_f ;;
		3) config_letra_c ;;
		4) ing_vocal ;;
		5) algoritmo1 ;;
		6) algoritmo2 ;;
		7) salir ; exit 0 ;; #La funcion cierra el sistema. El exit finaliza el case.
		*) echo "La opción no es valida. Intentelo de nuevo." ;; #Para las otras opciones que no estan en el case.
	esac
done
}



menú(){
	if [ "$ok" == "true" ]; then #Si las credenciales son correctas, lo dirigimos al menú.
        	echo "Usted ha ingresado al sistema."
		opciones_menú
		seleccionar_opcion
	else
        	echo "Error en la inicialización" #Credenciales incorrectas, no puede ingresar al menú.
	fi
}



solicitar_y_autenticar #Llamamos la funcion para solicitar y autenticar el us y la ca.

menú #Llamamos al menú si las credenciales estan ok, sino mostramos mensaje de error.

