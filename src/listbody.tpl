
#if !defined(LISTBODY_TEMPLATE)
#define LISTBODY_TEMPLATE


template <class Info> List<Info>::List ()
{
	try
	{
		start = new Listentry;
	}
	catch (xalloc)
	{
		cerr << "\n"
				"Konnte keinen Speicher fuer Listentry anfordern!\n";
		exit(1);
	}
	numb = 1 ;
	end = start ;
	act = start ;
	start->index = 0 ;
	start->before = NULL ;
	start->after = NULL ; }


template<class Info> List<Info>::~List()
{
//	printf("numb vor delete %d\n", numb);
	while (start->after != NULL)
	{
		start = start->after;
		numb--;
		delete start->before;
	}
//	printf("numb nach delete %d\n", --numb);
	delete end;
}

template <class Info> int List<Info>::append(Info i) {
	try
	{
		end->after = new Listentry;
	}
	catch (xalloc)
	{
		cerr << "\n"
				"Konnte keinen Speicher fuer Listentry anfordern!\n";
		exit(1);
	}
	numb++ ;
	end->after->before = end ;
	end = end->after ;
	end->after = NULL ;
	end->i = i ;
	end->index = end->before->index+1 ;
	return(end->index) ; }

template <class Info> Info* List<Info>::xappend(Info i) {
	try
	{
		end->after = new Listentry;
	}
	catch (xalloc)
	{
		cerr << "\n"
				"Fehler: Konnte keinen Speicher far Listentry anfordern!\n";
		exit(1);
	}
	numb++ ;
	end->after->before = end ;
	end = end->after ;
	end->after = NULL ;
	end->i = i ;
	end->index = end->before->index+1 ;
	return(&(end->i)) ; }

template <class Info> void List<Info>::reset() {act = start->after ;}

template <class Info> Info List<Info>::get(int indexnumber) {
	if (indexnumber <= 0) {
//		syndata_error("List_get","index less than 1",2) ;
		return(errorvalue) ; }
	if (act == NULL)
		reset() ;
	while (act != NULL) {
		if (act->index == indexnumber)
			return(act->i) ;
		if (act->index < indexnumber)
			if (act == end)
				break ;
			else
				act = act->after ;
		if (act->index > indexnumber)
			if (act == start->after)
				break ;
			else
				act = act->before ; }
	return(errorvalue) ; }

template <class Info> int List<Info>::get_number() {if (act == NULL) return(-1); else return(act->index) ; }

template <class Info> Info List<Info>::get_and_advance() {
	if (act == NULL) {
		return(errorvalue) ; }
	Info i = act->i ;
	act = act->after ;
	return(i) ; }

template <class Info> Info List<Info>::exclude_and_advance_and_get() {
	if ((act == NULL) || (act == start))
		return(errorvalue) ;
	if (act->after == NULL) {
		end = act->before ;
		act->before->after = NULL ;
		delete(act) ;
		act = NULL ;
		return(errorvalue) ; }
	Info i = act->after->i ;
	Listentry* pact = act->after ;
	act->before->after = act->after ;
	act->after->before = act->before ;
	delete(act) ;
	act = pact ;
	return(i) ; }

template <class Info> void List<Info>::clear() {
	reset() ;
	while (act != NULL && act != start)
		exclude_and_advance_and_get() ; }

template <class Info> Info List<Info>::get() {
	if (act == NULL) {
//		syndata_error("List_get()","end of list",1000) ;
		return(errorvalue) ; }
	return(act->i) ; }

template <class Info> void List<Info>::insert(Info i, int index)
{
	Listentry *newentry;

	get(index) ;

	try
	{
		newentry = new Listentry;
	}
	catch (xalloc)
	{
		cerr << "\n"
				"Fehler: Konnte keinen Speicher fuer Listentry anfordern!\n";
		exit(1);
	}
	newentry->i = i ;
	newentry->index = act->index+1 ;
	newentry->before = act ;
	newentry->after = act->after ;
	act->after->before = newentry ;
	act->after = newentry ;
	act = newentry->after ;
	while (act != NULL) {
		act->index += 1 ;
		act = act->after ; }
	get(index+1) ; }

template <class Info> void List<Info>::exclude(int index) {
	Listentry* l ;
	get(index) ;
	if (act->after != NULL)
		act->after->before = act->before ;
	else
		end = act->before ;
	act->before->after = act->after ;
	l = act ;
	act = act->after ;
	delete(l) ;
	while (act != NULL) {
		act->index -= 1 ;
		act = act->after ; }
	get(index) ; }

template <class Info> int List<Info>::advance() {
	if (act == NULL)
		return(-1) ;
	if (act->after == NULL)
		return(-1) ;
	act = act->after ;
	return(1) ; }

template <class Info> int List<Info>::decrease() {
	if (act == NULL)
		return(-1) ;
	if (act->before == start)
		return(-1) ;
	act = act->before ;
	return(1) ; }

template <class Info> int List<Info>::length() {
	return(end->index) ; }


#endif

