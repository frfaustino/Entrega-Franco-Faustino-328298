# Entrega Franco Faustino - 328298

#funcion para solicitar usuario, contrasena y verificar que sean correctas.
solicitar_y_autenticar(){
	echo"" #Para que aparezca una fila vacia (cuestion estetica).
	usuario=usuario
	contrasena=contrasena
	ok=false
	read -p "Ingrese el nombre de usuario: " usuario #Pedimos el usuario y lo guardamos en la variable usuario.
	echo""
	read -p  "Ingrese la contraseña: " contrasena #Lo mismo.
	echo""
	dato_ingresado=$usuario:$contrasena #Concatenamos el US y la CA en una variable.
	buscar=$(grep $dato_ingresado usuarios.txt) #Buscamos la variable que tiene el US y la CA en el archivo donde estan los US.
	if [ "$buscar" == "$dato_ingresado" ]; then #Verificamos que las dos variables sean iguales.
        	echo "Usuario y clave correcta. Iniciando el programa..."
		echo""
		ok=true #Esta variable es para luego darle permiso a acceder al menú o no.
	else
		echo "Usuario y/o clave incorrecta."
		echo""
	fi
}


#funcion para mostrar al usuario con que numero acceden a cada opcion.
opciones_menú(){
	echo ""
	echo "Menú Principal"
	echo ""
	echo "1) Listar los usuarios registrados"
	echo "2) Dar de alta un usuario"
	echo "3) Configurar letra de inicio"
	echo "4) Configurar letra fin"
	echo "5) Configurar letra contenida"
	echo "6) Consultar diccionario"
	echo "7) Ingresar vocal"
        echo "8) Listar palabras del diccionario con esa vocal"
        echo "9) Algoritmo 1"
        echo "10) Algoritmo 2"
        echo "11) Salir"
}


dibujo_usuario_registrado(){ #Fines esteticos, dibuja un Tic para el alta de usuarios.
	echo "               "
	echo "             ."
	echo "           .      ¡Uno más!"
	echo "   .     .        El usuario se ha registrado correctamente."
	echo "    .  ."
	echo "     ."
	echo ""
}



salir(){ #Para salir del menu.
	echo ""
	echo "Saliendo del sistema ... "
	echo ""
	echo "El sistema se ha cerrado."
	echo ""
	itera=false #Cambia el valor, por lo tanto while deja de iterar.
}



listar_usuarios(){ #Funcion para mostrar en forma de fila todos los usuarios registrados.
	echo""
	echo "Los usuarios registrados son: "
	echo ""
	tail -n +2 usuarios.txt | cut -d':' -f1 #Tail para que tome lin 2 en adelante, cut para que extraiga el campo antes de : . 
	echo ""
}



dar_alta(){ #Funcion para agregar nuevos usuarios:contrasenas a nuestrsto usuarios.txt
	seguir=true #Para que el while itere hasta que se ingrese un usuario que no exista.
	while [ "$seguir" == "true" ]; do
		echo""
		read -p "Ingrese el nuevo nombre de usuario, recuerda que no debe existir previamente: " nuevo_usuario
		nombres_iguales="$(grep -c $nuevo_usuario usuarios.txt)" #Usamos -c para que muestre la cantidad de veces que lo encontro en el archivo
		echo""
		if [ "$nombres_iguales" == "1" ]; then #Si la cantidad es 1, entonces el nombre ya existe.
			echo "El usuario ya existe, pruebe con otro nombre."
			echo ""
		else
			seguir=false #Si la cantidad no es uno, el nombre no existe y le permitimos ingresar la contrasena. Terminamos bucle.
			read -p "Ingrese la contraseña: " nueva_contrasena
			echo ""
			echo "$nuevo_usuario:$nueva_contrasena" >> usuarios.txt
			echo ""
			dibujo_usuario_registrado
		fi
	done
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


#Volcamos el informe al archivo resultado diccionario.
informe_diccionario(){
	echo "" >> resultado_diccionario.txt
	echo "La consulta al diccionario fue realizada por $usuario" >> resultado_diccionario.txt
	echo "En la fecha $fecha" >> resultado_diccionario.txt
	echo "La cantidad de palabras listadas fue de : $cantidad_palabras" >> resultado_diccionario.txt
	echo "La cantidad total de palabras en nuestro diccionario es de : $palabras_totales" >> resultado_diccionario.txt
	echo "El porcentaje de palabras listadas (respecto al total) es de : $porcentaje_palabras %" >> resultado_diccionario.txt
	echo ""
}


#Funcion para consultar en el diccionario con los parametros de letra i,f y c. Se asume que son ingresadas antes de llamar esta funcion.
consultar_dic(){
	echo ""
	echo "Las palabras que comienzan con:"
	echo ""	
	echo "Letra inicial: $letra_inicio"
	echo ""
	echo "Letra contenida: $letra_contenida"
	echo ""
	echo "Letra final: $letra_final"
	echo ""
	mostrar="$(grep -e "^$letra_inicio" diccionario.txt | grep -e "$letra_contenida" | grep -e "$letra_final$")" #Con grep -e, nos permite darle varios patrones de busqueda. Creamos esta variable para luego contar las palabras que se mostraron.
	grep -e "^$letra_inicio" diccionario.txt | grep -e "$letra_contenida" | grep -e "$letra_final$" #Mostramos las palabras que cumplen los parametros.
	fecha=$(date "+%Y-%m-%d %H:%M:%S") #Para obtener la fecha exacta del momento en que se ejecuta la funcion.
	cantidad_palabras=$(echo "$mostrar" | wc -w) #Cuenta la cantidad de palabras que se mostraron. 
	palabras_totales=$(wc -w < diccionario.txt)  #Cuenta la cantidad de palabras del diccionario.
	porcentaje_palabras=$(echo "scale=2; ($cantidad_palabras * 100) / $palabras_totales" | bc) #Utilizamos el 2 en scale para avisarle a bc que haga el calculo con dos decimales.
	informe_diccionario #Invocamos la funcion para que haga el informe y lo envie a resultado diccionario.
}


#Funcion para mostrar en forma de lista las palabras que contienen esa vocal.
listar_palabras(){
	echo "La lista de palabras del diccionario que contienen esta vocal son: "
	echo ""
	grep $letra_vocal diccionario.txt # Grep dara de forma predeterminada en forma de lista todas las palabras que contengan esa letra.
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
		1) listar_usuarios ;;
		2) dar_alta ;;
		3) config_letra_i ;;
		4) config_letra_f ;;
		5) config_letra_c ;;
		6) consultar_dic ;;
		7) ing_vocal ;;
		8) listar_palabras ;;
		9) algoritmo1 ;;
		10) algoritmo2 ;;
		11) salir ; exit 0 ;; #La funcion cierra el sistema. El exit finaliza el case.
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

