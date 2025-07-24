

En la siguiente aplicación tenemos una app que consulta la información de un sitio de videojuegos, donde se visualizar información los juegos más recientes. 


Recuros API
🔗 https://www.freetogame.com


En dicha aplicación resolverlos bugs

🛠️ Lista de tareas a realizar

	1.- Revisar problemas de conexión al sitio de juegos, nos informaron que se subió un cambio por accidente y que afecto el consumo de los servicios. Revisar folder Env y verificar en que file está el fallo, recordar que el sitio fue nombrado anteriormente. 

	2.- Agregar un sistema de alerta visual (ej. Alert, Toast o Snackbar) cuando la llamada a los servicios falle (timeout, 500, sin conexión, etc.). 

	3. - En la vista principal (HomeView), algunas imágenes del listado pueden venir corruptas o vacías. Utiliza el componente EmptyState (ya existente) para manejar esos casos y evitar espacios en blanco 

    4.  La vista de géneros está actualmente desordenada, tiene que estar ordenada alfabéticamente. 

	5.- En la línea 30 de la vista de detalle en HomeView, hay una animación que debe alinearse visualmente al diseño general. 
        - Ajustar la animación a la vista del detalle  
        - Ajustar el tiempo a una animación más fluida. 

	6.- Nos información sobre la actualización de algunos campos en el servicio de detalle, lo cual está ocasionando un crashs en el botón de SO Requirements, resolver     dicho Fix. 

	7.- Asegurarse que la app no falle si el API devuelve datos mal formateados o incompletos (campos nil, tipo incorrecto, etc.). Usar guard, optional, o default values para protegerse. 