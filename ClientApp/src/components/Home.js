import React, { useState } from 'react';
import axios from "axios";

export const Home = (props) => {
    const [computers, setComputers] = useState([]);
    const [searchQuery, setSearchQuery] = useState(""); // **New search state**
    const [newConfig, setNewConfig] = useState({
        processorManufacturer: "",
        processorDescription: "",

        storageCapacity: "1.7",
        storageUnit: "TB",
        storageType: "SSD",

        ramCapacity: "64",
        ramUnit: "GB",

        ports: [
            { portType: "USB-C", portCount: 2 },
            { portType: "HDMI", portCount: 1 },
            { portType: "DisplayPort", portCount: 1 }
        ]

    });

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
            //Procesor Info
            const processorData = {
                manufacturer: newConfig.processorManufacturer,
                description: newConfig.processorDescription
            };

            //Storage Info
            const storageData = {
                capacity: newConfig.storageCapacity,
                unit: newConfig.storageUnit,
                type: newConfig.storageType,
            };

            // RAM Info
            const ramData = {
                capacity: newConfig.ramCapacity,
                unit: newConfig.ramUnit
            };

            //Combine data into single payload
            const computerData = {
                processor: processorData,
                storage: storageData,
                ram: ramData,
                ports: newConfig.ports
            };

            const response = await axios.post('/computer/AddComputer', computerData, {
                headers: { 'Content-Type': 'application/json' }
            });

            alert(response.data.message); // Notify the user of the POST response
            //Clear form
            resetData();
            // Refresh data after adding a new entry
            handleLoadClicked();

        } catch (error) {

            console.error('Error adding data:', error);
            //alert('Error adding data:', error);
            alert('Failed to add data');

        }
    };

    // Function to update form fields
    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setNewConfig((prevConfig) => ({ ...prevConfig, [name]: value }));
    };

    //Clean form & reset data to original state.
    const resetData = () => {
        setNewConfig({
            processorManufacturer: "",
            processorDescription: "",

            storageCapacity: "1.7",
            storageUnit: "TB",
            storageType: "SSD",

            ramCapacity: "64",
            ramUnit: "GB",

            ports: [
                { portType: "USB-C", portCount: 2 },
                { portType: "HDMI", portCount: 1 },
                { portType: "DisplayPort", portCount: 1 }
            ]

        }); 

    };

    //Handle Search Function
    const handleSearchClicked = async () => {
        try {
            const response = await axios.get(`/computer/Search?processorDescription=${searchQuery}`);
            setComputers(response.data);  // Set search results to state
        } catch (error) {
            console.error('Error fetching data:', error);
            alert('Failed to load data');
        }
    };
    
    return (
        <div className="container my-5 p-4 bg-light rounded shadow">
            <h1 id="tableLabel">Computer Catalog</h1>

            {/* **Search Input and Button** */}
            <div className="input-group mb-3">
                <input
                    type="text"
                    className="form-control"
                    placeholder="Search by Processor Description"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                />
                <button onClick={handleSearchClicked} className="btn btn-primary">Search</button>
            </div>


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



            <div className="container my-5 p-4 bg-light rounded shadow">

                <h5>Add new computer:</h5>

                <form onSubmit={handleAddSubmit} className="row g-10">

                    <div className="row mb-4">
                        <div className="col-md-3">
                            <label htmlFor="manufacturer" className="form-label">Processor</label>
                            <input
                                type="text"
                                name="processorManufacturer"
                                placeholder="Processor Manufacturer"
                                required
                                className="form-control"
                                value={newConfig.processorManufacturer}
                                onChange={handleInputChange}
                            />

                        </div>

                        <div className="col-md-9">
                            <label htmlFor="description" className="form-label">Description</label>
                            <input
                                type="text"
                                name="processorDescription"
                                placeholder="Processor Description"
                                required
                                className="form-control"
                                value={newConfig.processorDescription}
                                onChange={handleInputChange}
                            />

                        </div>

                    </div>

                    <div className="row mb-3">
                        <div className="col-md-3">
                            <br />
                            <button type="submit" className="btn btn-success w-50">Add</button>
                            {/*<input type="submit" value="Add" className="btn btn-success w-100" />*/}

                        </div>
                    </div>

                </form>

            </div>



        </div>
    );
}