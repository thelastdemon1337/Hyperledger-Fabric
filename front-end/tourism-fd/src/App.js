import './App.css';
import { useState } from 'react';

function App() {
  const [formId, setFormId] = useState("")
  const [formData, setFormData] = useState("")
  const handleSubmit = async (e) => {
    e.preventDefault()
    const data = {
      username: formId,
      orgName: formData
    }
    try {
      await fetch("http://localhost:4000/users", {
        method: "POST",
        // mode: 'no-cors',
        headers: {
          'Content-type': 'application/json'
        },
        body: data
      })
        .then(response => {
          if (!response.ok) {
            throw response
          }
        })
        .then(json => {
          console.log(json);
        })
    } catch (error) {
      console.log("err", error);
    }

  }
  return (
    <div className="App">
      <div>
        <input placeholder='form ID' value={formId} onChange={e => setFormId(e.target.value)} />
        <input placeholder='form Data' value={formData} onChange={e => setFormData(e.target.value)} />
        <button onClick={handleSubmit}>Submit</button>
      </div>
    </div>
  );
}

export default App;
