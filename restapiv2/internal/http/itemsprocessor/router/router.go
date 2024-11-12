package router

import (
	"net/http"
	"restapiv2/internal/http/itemsprocessor/handlers"
	"github.com/gorilla/mux"
)

func NewItemsProcessorRouter() *mux.Router {
	r := mux.NewRouter()
	r.HandleFunc("/stat", StatHandler)
	r.HandleFunc("/item/{key}", GetItemHandler)
	r.HandleFunc("/item/{key}/{action}", PostHandler)
	r.HandleFunc("/item/{key}/incr/{increment}", Increasehandler)
	r.Use(CountStat)
	return r
}

func StatHandler(w http.ResponseWriter, r *http.Request){
	switch r.Method {
	case http.MethodGet:
		handlers.PrintStat(w)
	default:
		http.Error(w, http.StatusText(http.StatusMethodNotAllowed), http.StatusMethodNotAllowed)
	}
}

func GetItemHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	key := vars["key"]
	switch r.Method {
	case http.MethodGet:
		handlers.GetItem(w, key)
	case http.MethodPut:
		handlers.PutItem(w, r, key)
	case http.MethodDelete:
	default:
		http.Error(w, http.StatusText(http.StatusMethodNotAllowed), http.StatusMethodNotAllowed)
	}
}

func PostHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodPost {
		vars := mux.Vars(r)
		// key := vars["key"]
		action := vars["action"]
		
		switch action {
		case "reverse":
		case "sort":
		case "dedup":
		default: 
			http.Error(w, "Unknown action", http.StatusBadRequest)
		}
	} else {
		http.Error(w, http.StatusText(http.StatusMethodNotAllowed), http.StatusMethodNotAllowed)
	}
}

func Increasehandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodPost {
		vars := mux.Vars(r)
		key := vars["key"]
		increment := vars["increment"]
		handlers.IncreaseItem(w, key, increment)
	} else {
		http.Error(w, http.StatusText(http.StatusMethodNotAllowed), http.StatusMethodNotAllowed)
	}
}