import React, { useState } from 'react';
import axios from "axios";

export const Home = (props) => {
    const [computers, setComputers] = useState([]);

    const handleLoadClicked = async () => {
        try {
            const response = await axios.get('/computer');
            setComputers(response.data);  // Set fetched data to state
        } catch (error) {
            console.error('Error fetching data:', error);
            alert('Failed to load data');
        }
    };

    const handleAddSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post('/computer');
            alert(response.data); // Notify the user of the POST response
            handleLoadClicked();  // Refresh data after adding a new entry
        } catch (error) {
            console.error('Error adding data:', error);
            alert('Failed to add data');
        }
    };

    return (
        <div className="container my-5 p-4 bg-light rounded shadow">
            <h1 id="tableLabel">Computer Catalog</h1>
            <div>Fill out the table below based on your database design</div>
            <br />
            <button onClick={handleLoadClicked} className="btn btn-primary me-3">Load Data</button>
            <br />
            <br />
            <div className="table-responsive">
                <table className="table table-striped table-bordered text-center" aria-labelledby="tableLabel">
                    <thead className="table-primary">
                        <tr>
                            <th>Config ID</th>
                            <th>RAM</th>
                            <th>Storage</th>
                            <th>Processor</th>
                            <th>Ports</th>
                        </tr>
                    </thead>
                    <tbody>
                        {computers.map((computer) => (
                            <tr key={computer.configId}>
                                <td>{computer.configId}</td>
                                <td>{computer.ram.capacity} {computer.ram.unit}</td>
                                <td>{computer.storage.capacity} {computer.storage.unit}</td>
                                <td>{computer.processor.description}</td>
                                <td>
                                    {computer.ports
                                        .map((port) => `${port.portCount} x ${port.portType}`)
                                        .join(', ')}
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            <div className="mt-10">

                <h5>Implement a form to add a row to the table based on your design</h5>

                <form onSubmit={handleAddSubmit} className="row g-10">
                    <div className="col-md-8">
                        <input placeholder="Enter data" required className="form-control" />
                    </div>

                    <div className="col-md-2">
                        <input type="submit" value="Add" className="btn btn-success w-100" />
                    </div>
                    
                </form>

            </div>

        </div>


    );
}